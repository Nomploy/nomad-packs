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

  # All-in-one: Postgres starts first (prestart sidecar); Miniflux reaches it on
  # 127.0.0.1, runs migrations and creates the admin on first start. count stays 1.
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
        POSTGRES_DB       = "miniflux"
        POSTGRES_USER     = "miniflux"
        POSTGRES_PASSWORD = "[[ var "db_password" . ]]"
        PGPORT            = "[[ var "db_port" . ]]"
      }

      resources {
        cpu    = [[ (var "postgres_resources" .).cpu ]]
        memory = [[ (var "postgres_resources" .).memory ]]
      }
    }

    task "miniflux" {
      driver = "docker"

      config {
        image        = "[[ var "image" . ]]"
        network_mode = "host"
        ports        = ["http"]
      }

      env {
        LISTEN_ADDR    = "0.0.0.0:[[ var "port" . ]]"
        DATABASE_URL   = "postgres://miniflux:[[ var "db_password" . ]]@127.0.0.1:[[ var "db_port" . ]]/miniflux?sslmode=disable"
        RUN_MIGRATIONS = "1"
        CREATE_ADMIN   = "1"
        ADMIN_USERNAME = "[[ var "admin_user" . ]]"
        ADMIN_PASSWORD = "[[ var "admin_password" . ]]"
        [[- if ne (var "base_url" .) "" ]]
        BASE_URL       = "[[ var "base_url" . ]]"
        [[- end ]]
      }

      resources {
        cpu    = [[ (var "miniflux_resources" .).cpu ]]
        memory = [[ (var "miniflux_resources" .).memory ]]
      }
    }
  }
}
