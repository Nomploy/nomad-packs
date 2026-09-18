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

  # All-in-one: PostgreSQL + ClickHouse start first (prestart sidecars); Plausible
  # reaches both on 127.0.0.1, creates/migrates the databases, then serves. A cold
  # DB on first boot is self-healed by the restart block. count stays 1 (local volumes).
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
      port "clickhouse" {
        static = [[ var "clickhouse_port" . ]]
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
        POSTGRES_DB       = "plausible"
        POSTGRES_USER     = "plausible"
        POSTGRES_PASSWORD = "[[ var "db_password" . ]]"
        PGPORT            = "[[ var "db_port" . ]]"
      }

      resources {
        cpu    = [[ (var "postgres_resources" .).cpu ]]
        memory = [[ (var "postgres_resources" .).memory ]]
      }
    }

    # --- ClickHouse (prestart sidecar) ------------------------------------
    task "clickhouse" {
      driver = "docker"

      lifecycle {
        hook    = "prestart"
        sidecar = true
      }

      config {
        image        = "[[ var "clickhouse_image" . ]]"
        network_mode = "host"
        ports        = ["clickhouse"]

        ulimit {
          nofile = "262144:262144"
        }

        mount {
          type   = "volume"
          source = "[[ var "clickhouse_data_volume" . ]]"
          target = "/var/lib/clickhouse"
        }
      }

      resources {
        cpu    = [[ (var "clickhouse_resources" .).cpu ]]
        memory = [[ (var "clickhouse_resources" .).memory ]]
      }
    }

    # --- Plausible (main) -------------------------------------------------
    task "plausible" {
      driver = "docker"

      config {
        image        = "[[ var "image" . ]]"
        network_mode = "host"
        ports        = ["http"]
        entrypoint   = ["sh", "-c"]
        args = [
          "/entrypoint.sh db createdb && /entrypoint.sh db migrate && /entrypoint.sh run",
        ]
      }

      env {
        HTTP_PORT              = "[[ var "port" . ]]"
        [[- if ne (var "base_url" .) "" ]]
        BASE_URL              = "[[ var "base_url" . ]]"
        [[- else ]]
        BASE_URL              = "http://localhost:[[ var "port" . ]]"
        [[- end ]]
        SECRET_KEY_BASE        = "[[ var "secret_key_base" . ]]"
        DISABLE_REGISTRATION   = "[[ var "disable_registration" . ]]"
        DATABASE_URL           = "postgres://plausible:[[ var "db_password" . ]]@127.0.0.1:[[ var "db_port" . ]]/plausible"
        CLICKHOUSE_DATABASE_URL = "http://127.0.0.1:[[ var "clickhouse_port" . ]]/plausible_events_db"
      }

      resources {
        cpu    = [[ (var "plausible_resources" .).cpu ]]
        memory = [[ (var "plausible_resources" .).memory ]]
      }
    }
  }
}
