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

  # All-in-one: Postgres starts first (prestart sidecar) and shares the host
  # network namespace, so Metabase reaches it on 127.0.0.1. Metabase runs its
  # migrations on start and retries the DB connection, so a brief startup race is
  # self-healing. count stays 1 (local Postgres volume).
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
        POSTGRES_DB       = "metabase"
        POSTGRES_USER     = "metabase"
        POSTGRES_PASSWORD = "[[ var "db_password" . ]]"
        PGPORT            = "[[ var "db_port" . ]]"
      }

      resources {
        cpu    = [[ (var "postgres_resources" .).cpu ]]
        memory = [[ (var "postgres_resources" .).memory ]]
      }
    }

    # --- Metabase (main) --------------------------------------------------
    task "metabase" {
      driver = "docker"

      config {
        image        = "[[ var "image" . ]]"
        network_mode = "host"
        ports        = ["http"]
      }

      env {
        MB_JETTY_PORT = "[[ var "port" . ]]"

        MB_DB_TYPE   = "postgres"
        MB_DB_DBNAME = "metabase"
        MB_DB_PORT   = "[[ var "db_port" . ]]"
        MB_DB_USER   = "metabase"
        MB_DB_PASS   = "[[ var "db_password" . ]]"
        MB_DB_HOST   = "127.0.0.1"
        [[- if ne (var "site_url" .) "" ]]
        MB_SITE_URL  = "[[ var "site_url" . ]]"
        [[- end ]]
        [[- if ne (var "encryption_key" .) "" ]]
        MB_ENCRYPTION_SECRET_KEY = "[[ var "encryption_key" . ]]"
        [[- end ]]
      }

      resources {
        cpu    = [[ (var "metabase_resources" .).cpu ]]
        memory = [[ (var "metabase_resources" .).memory ]]
      }
    }
  }
}
