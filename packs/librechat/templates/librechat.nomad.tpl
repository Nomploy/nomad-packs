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
      port "mongo" {
        static = [[ var "mongo_port" . ]]
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

    task "mongodb" {
      driver = "docker"

      lifecycle {
        hook    = "prestart"
        sidecar = true
      }

      config {
        image        = "[[ var "mongo_image" . ]]"
        network_mode = "host"
        args         = ["--port", "[[ var "mongo_port" . ]]", "--noauth"]

        mount {
          type   = "volume"
          source = "[[ var "mongo_data_volume" . ]]"
          target = "/data/db"
        }
      }

      resources {
        cpu    = [[ (var "mongo_resources" .).cpu ]]
        memory = [[ (var "mongo_resources" .).memory ]]
      }
    }

    task "librechat" {
      driver = "docker"

      config {
        image        = "[[ var "image" . ]]"
        network_mode = "host"
        ports        = ["http"]

        mount {
          type   = "volume"
          source = "[[ var "data_volume" . ]]"
          target = "/app/data"
        }
        mount {
          type   = "volume"
          source = "[[ var "uploads_volume" . ]]"
          target = "/app/uploads"
        }
        mount {
          type   = "volume"
          source = "[[ var "images_volume" . ]]"
          target = "/app/client/public/images"
        }
        mount {
          type   = "volume"
          source = "[[ var "logs_volume" . ]]"
          target = "/app/api/logs"
        }
      }

      env {
        HOST                = "0.0.0.0"
        PORT                = "[[ var "port" . ]]"
        MONGO_URI           = "mongodb://127.0.0.1:[[ var "mongo_port" . ]]/LibreChat"
        SEARCH              = "false"
        ALLOW_REGISTRATION  = "[[ var "allow_registration" . ]]"
        CREDS_KEY           = "[[ var "creds_key" . ]]"
        CREDS_IV            = "[[ var "creds_iv" . ]]"
        JWT_SECRET          = "[[ var "jwt_secret" . ]]"
        JWT_REFRESH_SECRET  = "[[ var "jwt_refresh_secret" . ]]"
        OPENAI_API_KEY      = "user_provided"
        ANTHROPIC_API_KEY   = "user_provided"
        GOOGLE_KEY          = "user_provided"
      }

      resources {
        cpu    = [[ (var "resources" .).cpu ]]
        memory = [[ (var "resources" .).memory ]]
      }
    }
  }
}
