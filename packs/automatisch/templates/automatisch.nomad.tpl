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
        POSTGRES_DB       = "automatisch"
        POSTGRES_USER     = "automatisch"
        POSTGRES_PASSWORD = "[[ var "db_password" . ]]"
        PGPORT            = "[[ var "db_port" . ]]"
      }

      resources {
        cpu    = [[ (var "db_resources" .).cpu ]]
        memory = [[ (var "db_resources" .).memory ]]
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
        args         = ["redis-server", "--port", "[[ var "redis_port" . ]]"]
      }

      resources {
        cpu    = [[ (var "redis_resources" .).cpu ]]
        memory = [[ (var "redis_resources" .).memory ]]
      }
    }

    task "web" {
      driver = "docker"

      config {
        image        = "[[ var "image" . ]]"
        network_mode = "host"
        ports        = ["http"]

        mount {
          type   = "volume"
          source = "[[ var "storage_volume" . ]]"
          target = "/automatisch/storage"
        }
      }

      env {
        HOST              = "[[ var "host" . ]]"
        PROTOCOL          = "[[ var "protocol" . ]]"
        PORT              = "[[ var "port" . ]]"
        APP_ENV           = "production"
        POSTGRES_HOST     = "127.0.0.1"
        POSTGRES_PORT     = "[[ var "db_port" . ]]"
        POSTGRES_DATABASE = "automatisch"
        POSTGRES_USERNAME = "automatisch"
        POSTGRES_PASSWORD = "[[ var "db_password" . ]]"
        REDIS_HOST        = "127.0.0.1"
        REDIS_PORT        = "[[ var "redis_port" . ]]"
        ENCRYPTION_KEY    = "[[ var "encryption_key" . ]]"
        WEBHOOK_SECRET_KEY = "[[ var "webhook_secret_key" . ]]"
        APP_SECRET_KEY    = "[[ var "app_secret_key" . ]]"
      }

      resources {
        cpu    = [[ (var "resources" .).cpu ]]
        memory = [[ (var "resources" .).memory ]]
      }
    }

    task "worker" {
      driver = "docker"

      config {
        image        = "[[ var "image" . ]]"
        network_mode = "host"

        mount {
          type   = "volume"
          source = "[[ var "storage_volume" . ]]"
          target = "/automatisch/storage"
        }
      }

      env {
        WORKER            = "true"
        APP_ENV           = "production"
        POSTGRES_HOST     = "127.0.0.1"
        POSTGRES_PORT     = "[[ var "db_port" . ]]"
        POSTGRES_DATABASE = "automatisch"
        POSTGRES_USERNAME = "automatisch"
        POSTGRES_PASSWORD = "[[ var "db_password" . ]]"
        REDIS_HOST        = "127.0.0.1"
        REDIS_PORT        = "[[ var "redis_port" . ]]"
        ENCRYPTION_KEY    = "[[ var "encryption_key" . ]]"
        WEBHOOK_SECRET_KEY = "[[ var "webhook_secret_key" . ]]"
        APP_SECRET_KEY    = "[[ var "app_secret_key" . ]]"
      }

      resources {
        cpu    = [[ (var "worker_resources" .).cpu ]]
        memory = [[ (var "worker_resources" .).memory ]]
      }
    }
  }
}
