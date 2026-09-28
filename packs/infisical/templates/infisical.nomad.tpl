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
        POSTGRES_DB       = "infisical"
        POSTGRES_USER     = "infisical"
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

    task "infisical" {
      driver = "docker"

      config {
        image        = "[[ var "image" . ]]"
        network_mode = "host"
        ports        = ["http"]
      }

      env {
        NODE_ENV          = "production"
        PORT              = "[[ var "port" . ]]"
        ENCRYPTION_KEY    = "[[ var "encryption_key" . ]]"
        AUTH_SECRET       = "[[ var "auth_secret" . ]]"
        DB_CONNECTION_URI = "postgres://infisical:[[ var "db_password" . ]]@127.0.0.1:[[ var "db_port" . ]]/infisical"
        REDIS_URL         = "redis://127.0.0.1:[[ var "redis_port" . ]]"
        SITE_URL          = "[[ var "site_url" . ]]"
      }

      resources {
        cpu    = [[ (var "resources" .).cpu ]]
        memory = [[ (var "resources" .).memory ]]
      }
    }
  }
}
