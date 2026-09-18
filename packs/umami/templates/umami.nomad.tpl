job "[[ var "job_name" . ]]" {
  namespace   = "[[ var "namespace" . ]]"
  datacenters = [[ var "datacenters" . | toStringList ]]
  type        = "service"

  [[- range $c := var "constraints" . ]]
  constraint {
    attribute = "[[ $c.attribute ]]"
    operator  = "[[ $c.operator ]]"
    value     = "[[ $c.value ]]"
  }
  [[- end ]]

  # All-in-one: Postgres starts first (prestart sidecar); Umami reaches it on
  # 127.0.0.1 and runs its migrations on start. count stays 1 (local PG volume).
  group "[[ var "job_name" . ]]" {
    count = 1

    network {
      mode = "host"
      port "http" {
        static = [[ var "port" . ]]
      }
      port "db" {
        static = [[ var "db_port" . ]]
      }
    }

    service {
      name     = "[[ var "job_name" . ]]"
      provider = "nomad"
      port     = "http"
    }

    restart {
      attempts = 5
      interval = "10m"
      delay    = "15s"
      mode     = "delay"
    }

    task "postgres" {
      driver = "docker"

      lifecycle {
        hook    = "prestart"
        sidecar = true
      }

      config {
        image        = "[[ var "postgres_image" . ]]"
        network_mode = "host"
        ports        = ["db"]

        mount {
          type   = "volume"
          source = "[[ var "db_data_volume" . ]]"
          target = "/var/lib/postgresql/data"
        }
      }

      env {
        POSTGRES_DB       = "umami"
        POSTGRES_USER     = "umami"
        POSTGRES_PASSWORD = "[[ var "db_password" . ]]"
        PGPORT            = "[[ var "db_port" . ]]"
      }

      resources {
        cpu    = [[ (var "postgres_resources" .).cpu ]]
        memory = [[ (var "postgres_resources" .).memory ]]
      }
    }

    task "umami" {
      driver = "docker"

      config {
        image        = "[[ var "image" . ]]"
        network_mode = "host"
        ports        = ["http"]
      }

      env {
        DATABASE_TYPE = "postgresql"
        DATABASE_URL  = "postgresql://umami:[[ var "db_password" . ]]@127.0.0.1:[[ var "db_port" . ]]/umami"
        PORT          = "[[ var "port" . ]]"
        HOSTNAME      = "0.0.0.0"
        [[- if ne (var "app_secret" .) "" ]]
        APP_SECRET    = "[[ var "app_secret" . ]]"
        [[- end ]]
      }

      resources {
        cpu    = [[ (var "umami_resources" .).cpu ]]
        memory = [[ (var "umami_resources" .).memory ]]
      }
    }
  }
}
