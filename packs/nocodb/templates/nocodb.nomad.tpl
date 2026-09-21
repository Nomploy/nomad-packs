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

  # All-in-one: Postgres starts first (prestart sidecar); NocoDB reaches it on
  # 127.0.0.1 and migrates its metadata on start. count stays 1 (local volumes).
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
      delay    = "20s"
      mode     = "delay"
    }

    # --- PostgreSQL (prestart sidecar) ------------------------------------
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
        POSTGRES_DB       = "nocodb"
        POSTGRES_USER     = "nocodb"
        POSTGRES_PASSWORD = "[[ var "db_password" . ]]"
        PGPORT            = "[[ var "db_port" . ]]"
      }

      resources {
        cpu    = [[ (var "postgres_resources" .).cpu ]]
        memory = [[ (var "postgres_resources" .).memory ]]
      }
    }

    # --- NocoDB (main) ----------------------------------------------------
    task "nocodb" {
      driver = "docker"

      config {
        image        = "[[ var "image" . ]]"
        network_mode = "host"
        ports        = ["http"]

        mount {
          type   = "volume"
          source = "[[ var "data_volume" . ]]"
          target = "/usr/app/data"
        }
      }

      env {
        PORT  = "[[ var "port" . ]]"
        NC_DB = "pg://127.0.0.1:[[ var "db_port" . ]]?u=nocodb&p=[[ var "db_password" . ]]&d=nocodb"
        [[- if ne (var "public_url" .) "" ]]
        NC_PUBLIC_URL = "[[ var "public_url" . ]]"
        [[- end ]]
        [[- if ne (var "jwt_secret" .) "" ]]
        NC_AUTH_JWT_SECRET = "[[ var "jwt_secret" . ]]"
        [[- end ]]
      }

      resources {
        cpu    = [[ (var "nocodb_resources" .).cpu ]]
        memory = [[ (var "nocodb_resources" .).memory ]]
      }
    }
  }
}
