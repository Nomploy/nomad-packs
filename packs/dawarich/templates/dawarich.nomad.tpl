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
        shm_size     = 1073741824

        mount {
          type   = "volume"
          source = "[[ var "db_data_volume" . ]]"
          target = "/var/lib/postgresql/data"
        }
      }

      env {
        POSTGRES_DB       = "dawarich_production"
        POSTGRES_USER     = "dawarich"
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
        args         = ["redis-server", "--port", "[[ var "redis_port" . ]]", "--save", "900", "1", "--appendonly", "no"]

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

    task "dawarich" {
      driver = "docker"

      config {
        image        = "[[ var "image" . ]]"
        network_mode = "host"
        ports        = ["http"]
        entrypoint   = ["web-entrypoint.sh"]
        command      = "bin/rails"
        args         = ["server", "-p", "[[ var "port" . ]]", "-b", "::"]

        mount {
          type   = "volume"
          source = "[[ var "public_volume" . ]]"
          target = "/var/app/public"
        }
        mount {
          type   = "volume"
          source = "[[ var "watched_volume" . ]]"
          target = "/var/app/tmp/imports/watched"
        }
        mount {
          type   = "volume"
          source = "[[ var "storage_volume" . ]]"
          target = "/var/app/storage"
        }
      }

      env {
        RAILS_ENV          = "production"
        SELF_HOSTED        = "true"
        STORE_GEODATA      = "true"
        REDIS_URL          = "redis://127.0.0.1:[[ var "redis_port" . ]]/0"
        DATABASE_HOST      = "127.0.0.1"
        DATABASE_PORT      = "[[ var "db_port" . ]]"
        DATABASE_USERNAME  = "dawarich"
        DATABASE_PASSWORD  = "[[ var "db_password" . ]]"
        DATABASE_NAME      = "dawarich_production"
        APPLICATION_HOSTS  = "localhost,::1,127.0.0.1"
        APPLICATION_PROTOCOL = "http"
        TIME_ZONE          = "[[ var "time_zone" . ]]"
        SECRET_KEY_BASE    = "[[ var "secret_key_base" . ]]"
        RAILS_LOG_TO_STDOUT = "true"
        WEB_CONCURRENCY    = "1"
      }

      resources {
        cpu    = [[ (var "resources" .).cpu ]]
        memory = [[ (var "resources" .).memory ]]
      }
    }

    task "sidekiq" {
      driver = "docker"

      config {
        image        = "[[ var "image" . ]]"
        network_mode = "host"
        entrypoint   = ["sidekiq-entrypoint.sh"]
        command      = "sidekiq"

        mount {
          type   = "volume"
          source = "[[ var "public_volume" . ]]"
          target = "/var/app/public"
        }
        mount {
          type   = "volume"
          source = "[[ var "watched_volume" . ]]"
          target = "/var/app/tmp/imports/watched"
        }
        mount {
          type   = "volume"
          source = "[[ var "storage_volume" . ]]"
          target = "/var/app/storage"
        }
      }

      env {
        RAILS_ENV          = "production"
        SELF_HOSTED        = "true"
        STORE_GEODATA      = "true"
        REDIS_URL          = "redis://127.0.0.1:[[ var "redis_port" . ]]/0"
        DATABASE_HOST      = "127.0.0.1"
        DATABASE_PORT      = "[[ var "db_port" . ]]"
        DATABASE_USERNAME  = "dawarich"
        DATABASE_PASSWORD  = "[[ var "db_password" . ]]"
        DATABASE_NAME      = "dawarich_production"
        APPLICATION_HOSTS  = "localhost,::1,127.0.0.1"
        APPLICATION_PROTOCOL = "http"
        TIME_ZONE          = "[[ var "time_zone" . ]]"
        SECRET_KEY_BASE    = "[[ var "secret_key_base" . ]]"
        RAILS_LOG_TO_STDOUT = "true"
        BACKGROUND_PROCESSING_CONCURRENCY = "3"
      }

      resources {
        cpu    = [[ (var "sidekiq_resources" .).cpu ]]
        memory = [[ (var "sidekiq_resources" .).memory ]]
      }
    }
  }
}
