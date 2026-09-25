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
      port "ml" {
        static = [[ var "ml_port" . ]]
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
        POSTGRES_USER        = "[[ var "db_user" . ]]"
        POSTGRES_PASSWORD    = "[[ var "db_password" . ]]"
        POSTGRES_DB          = "[[ var "db_name" . ]]"
        POSTGRES_INITDB_ARGS = "--data-checksums"
        PGPORT               = "[[ var "db_port" . ]]"
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

    task "machine-learning" {
      driver = "docker"

      lifecycle {
        hook    = "prestart"
        sidecar = true
      }

      config {
        image        = "[[ var "machine_learning_image" . ]]"
        network_mode = "host"

        mount {
          type   = "volume"
          source = "[[ var "model_cache_volume" . ]]"
          target = "/cache"
        }
      }

      resources {
        cpu    = [[ (var "machine_learning_resources" .).cpu ]]
        memory = [[ (var "machine_learning_resources" .).memory ]]
      }
    }

    task "immich-server" {
      driver = "docker"

      config {
        image        = "[[ var "image" . ]]"
        network_mode = "host"
        ports        = ["http"]

        mount {
          type   = "volume"
          source = "[[ var "upload_volume" . ]]"
          target = "/data"
        }
      }

      env {
        IMMICH_PORT                 = "[[ var "port" . ]]"
        DB_HOSTNAME                 = "127.0.0.1"
        DB_PORT                     = "[[ var "db_port" . ]]"
        DB_USERNAME                 = "[[ var "db_user" . ]]"
        DB_PASSWORD                 = "[[ var "db_password" . ]]"
        DB_DATABASE_NAME            = "[[ var "db_name" . ]]"
        REDIS_HOSTNAME              = "127.0.0.1"
        REDIS_PORT                  = "[[ var "redis_port" . ]]"
        IMMICH_MACHINE_LEARNING_URL = "http://127.0.0.1:[[ var "ml_port" . ]]"
      }

      resources {
        cpu    = [[ (var "resources" .).cpu ]]
        memory = [[ (var "resources" .).memory ]]
      }
    }
  }
}
