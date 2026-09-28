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

    task "centrifugo" {
      driver = "docker"

      config {
        image        = "[[ var "image" . ]]"
        network_mode = "host"
        ports        = ["http"]
        command      = "centrifugo"
        ulimit {
          nofile = "65536:65536"
        }
      }

      env {
        CENTRIFUGO_PORT                        = "[[ var "port" . ]]"
        CENTRIFUGO_ADMIN_ENABLED               = "true"
        CENTRIFUGO_ADMIN_PASSWORD              = "[[ var "admin_password" . ]]"
        CENTRIFUGO_ADMIN_SECRET                = "[[ var "admin_secret" . ]]"
        CENTRIFUGO_HTTP_API_KEY                = "[[ var "api_key" . ]]"
        CENTRIFUGO_CLIENT_TOKEN_HMAC_SECRET_KEY = "[[ var "token_hmac_secret" . ]]"
      }

      resources {
        cpu    = [[ (var "resources" .).cpu ]]
        memory = [[ (var "resources" .).memory ]]
      }
    }
  }
}
