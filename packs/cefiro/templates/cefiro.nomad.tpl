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
      port "obscura" {
        static = [[ var "obscura_port" . ]]
      }
    }

    service {
      name     = "[[ var "job_name" . ]]"
      provider = "nomad"
      port     = "http"
    }

    restart {
      attempts = 3
      interval = "5m"
      delay    = "15s"
      mode     = "delay"
    }

    # chown the uploads volume so the app (uid 1000) can write it.
    task "init" {
      driver = "docker"

      lifecycle {
        hook    = "prestart"
        sidecar = false
      }

      config {
        image   = "busybox:latest"
        command = "sh"
        args    = ["-c", "chown -R 1000:1000 /app/uploads"]

        mount {
          type   = "volume"
          source = "[[ var "uploads_volume" . ]]"
          target = "/app/uploads"
        }
      }

      resources {
        cpu    = 50
        memory = 64
      }
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
        POSTGRES_DB       = "cefiro"
        POSTGRES_USER     = "postgres"
        POSTGRES_PASSWORD = "[[ var "db_password" . ]]"
        PGPORT            = "[[ var "db_port" . ]]"
      }

      resources {
        cpu    = [[ (var "postgres_resources" .).cpu ]]
        memory = [[ (var "postgres_resources" .).memory ]]
      }
    }

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
        args         = ["--port", "[[ var "redis_port" . ]]"]

        mount {
          type   = "volume"
          source = "[[ var "redis_data_volume" . ]]"
          target = "/data"
        }
      }

      resources {
        cpu    = [[ (var "redis_resources" .).cpu ]]
        memory = [[ (var "redis_resources" .).memory ]]
      }
    }

    task "obscura" {
      driver = "docker"

      lifecycle {
        hook    = "prestart"
        sidecar = true
      }

      config {
        image        = "[[ var "obscura_image" . ]]"
        network_mode = "host"
        ports        = ["obscura"]
        shm_size     = 268435456
      }

      resources {
        cpu    = [[ (var "obscura_resources" .).cpu ]]
        memory = [[ (var "obscura_resources" .).memory ]]
      }
    }

    task "cefiro" {
      driver = "docker"

      config {
        image        = "[[ var "image" . ]]"
        network_mode = "host"
        ports        = ["http"]

        mount {
          type   = "volume"
          source = "[[ var "uploads_volume" . ]]"
          target = "/app/uploads"
        }
      }

      env {
        NODE_ENV              = "production"
        PORT                  = "[[ var "port" . ]]"
        HOSTNAME              = "0.0.0.0"
        AUTH_URL              = "[[ if ne (var "base_url" .) "" ]][[ var "base_url" . ]][[ else ]]http://localhost:[[ var "port" . ]][[ end ]]"
        DATABASE_URL          = "postgres://postgres:[[ var "db_password" . ]]@127.0.0.1:[[ var "db_port" . ]]/cefiro"
        REDIS_URL             = "redis://127.0.0.1:[[ var "redis_port" . ]]"
        OBSCURA_ENDPOINT      = "ws://127.0.0.1:[[ var "obscura_port" . ]]"
        MASTER_KEY            = "[[ var "master_key" . ]]"
        UPLOADS_DIR           = "/app/uploads"
        PASSWORD_AUTH_ENABLED = "[[ var "password_auth_enabled" . ]]"
      }

      resources {
        cpu    = [[ (var "resources" .).cpu ]]
        memory = [[ (var "resources" .).memory ]]
      }
    }
  }
}
