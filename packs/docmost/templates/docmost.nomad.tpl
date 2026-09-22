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

  # All-in-one: Postgres + Redis start first (prestart sidecars); Docmost reaches
  # both on 127.0.0.1 and migrates on start. count stays 1 (local volumes).
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
      port "redis" {
        static = [[ var "redis_port" . ]]
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

    # chown the storage volume so Docmost (uid 1000) can write uploads.
    task "init" {
      driver = "docker"

      lifecycle {
        hook    = "prestart"
        sidecar = false
      }

      config {
        image   = "busybox:latest"
        command = "sh"
        args    = ["-c", "chown -R 1000:1000 /app/data/storage"]

        mount {
          type   = "volume"
          source = "[[ var "storage_volume" . ]]"
          target = "/app/data/storage"
        }
      }

      resources {
        cpu    = 50
        memory = 64
      }
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
        POSTGRES_DB       = "docmost"
        POSTGRES_USER     = "docmost"
        POSTGRES_PASSWORD = "[[ var "db_password" . ]]"
        PGPORT            = "[[ var "db_port" . ]]"
      }

      resources {
        cpu    = [[ (var "postgres_resources" .).cpu ]]
        memory = [[ (var "postgres_resources" .).memory ]]
      }
    }

    # --- Redis (prestart sidecar, ephemeral) ------------------------------
    task "redis" {
      driver = "docker"

      lifecycle {
        hook    = "prestart"
        sidecar = true
      }

      config {
        image        = "[[ var "redis_image" . ]]"
        network_mode = "host"
        ports        = ["redis"]
        args         = ["redis-server", "--port", "[[ var "redis_port" . ]]"]
      }

      resources {
        cpu    = 100
        memory = 128
      }
    }

    # --- Docmost (main) ---------------------------------------------------
    task "docmost" {
      driver = "docker"

      config {
        image        = "[[ var "image" . ]]"
        network_mode = "host"
        ports        = ["http"]

        mount {
          type   = "volume"
          source = "[[ var "storage_volume" . ]]"
          target = "/app/data/storage"
        }
      }

      env {
        PORT         = "[[ var "port" . ]]"
        APP_SECRET   = "[[ var "app_secret" . ]]"
        DATABASE_URL = "postgres://docmost:[[ var "db_password" . ]]@127.0.0.1:[[ var "db_port" . ]]/docmost"
        REDIS_URL    = "redis://127.0.0.1:[[ var "redis_port" . ]]"
        [[- if ne (var "app_url" .) "" ]]
        APP_URL      = "[[ var "app_url" . ]]"
        [[- end ]]
      }

      resources {
        cpu    = [[ (var "docmost_resources" .).cpu ]]
        memory = [[ (var "docmost_resources" .).memory ]]
      }
    }
  }
}
