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
        POSTGRES_DB       = "twenty"
        POSTGRES_USER     = "twenty"
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
        args         = ["redis-server", "--port", "[[ var "redis_port" . ]]", "--maxmemory-policy", "noeviction"]
      }

      resources {
        cpu    = [[ (var "redis_resources" .).cpu ]]
        memory = [[ (var "redis_resources" .).memory ]]
      }
    }

    task "server" {
      driver = "docker"

      config {
        image        = "[[ var "image" . ]]"
        network_mode = "host"
        ports        = ["http"]

        mount {
          type   = "volume"
          source = "[[ var "storage_volume" . ]]"
          target = "/app/packages/twenty-server/.local-storage"
        }
      }

      env {
        NODE_PORT       = "[[ var "port" . ]]"
        SERVER_URL      = "[[ var "server_url" . ]]"
        PG_DATABASE_URL = "postgres://twenty:[[ var "db_password" . ]]@127.0.0.1:[[ var "db_port" . ]]/twenty"
        REDIS_URL       = "redis://127.0.0.1:[[ var "redis_port" . ]]"
        APP_SECRET      = "[[ var "app_secret" . ]]"
        STORAGE_TYPE    = "local"
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
        command      = "yarn"
        args         = ["worker:prod"]

        mount {
          type   = "volume"
          source = "[[ var "storage_volume" . ]]"
          target = "/app/packages/twenty-server/.local-storage"
        }
      }

      env {
        SERVER_URL                     = "[[ var "server_url" . ]]"
        PG_DATABASE_URL                = "postgres://twenty:[[ var "db_password" . ]]@127.0.0.1:[[ var "db_port" . ]]/twenty"
        REDIS_URL                      = "redis://127.0.0.1:[[ var "redis_port" . ]]"
        APP_SECRET                     = "[[ var "app_secret" . ]]"
        STORAGE_TYPE                   = "local"
        DISABLE_DB_MIGRATIONS          = "true"
        DISABLE_CRON_JOBS_REGISTRATION = "true"
      }

      resources {
        cpu    = [[ (var "worker_resources" .).cpu ]]
        memory = [[ (var "worker_resources" .).memory ]]
      }
    }
  }
}
