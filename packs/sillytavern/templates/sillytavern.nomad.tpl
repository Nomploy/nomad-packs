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

    task "sillytavern" {
      driver = "docker"

      config {
        image        = "[[ var "image" . ]]"
        network_mode = "host"
        ports        = ["http"]

        mount {
          type   = "volume"
          source = "[[ var "config_volume" . ]]"
          target = "/home/node/app/config"
        }
        mount {
          type   = "volume"
          source = "[[ var "data_volume" . ]]"
          target = "/home/node/app/data"
        }
        mount {
          type   = "volume"
          source = "[[ var "plugins_volume" . ]]"
          target = "/home/node/app/plugins"
        }
        mount {
          type   = "volume"
          source = "[[ var "extensions_volume" . ]]"
          target = "/home/node/app/public/scripts/extensions/third-party"
        }
      }

      env {
        SILLYTAVERN_LISTEN            = "true"
        SILLYTAVERN_PORT              = "[[ var "port" . ]]"
        SILLYTAVERN_WHITELISTMODE     = "false"
        SILLYTAVERN_BASICAUTHMODE     = "[[ var "basic_auth" . ]]"
        SILLYTAVERN_BASICAUTHUSER_USERNAME = "[[ var "basic_auth_user" . ]]"
        SILLYTAVERN_BASICAUTHUSER_PASSWORD = "[[ var "basic_auth_password" . ]]"
      }

      resources {
        cpu    = [[ (var "resources" .).cpu ]]
        memory = [[ (var "resources" .).memory ]]
      }
    }
  }
}
