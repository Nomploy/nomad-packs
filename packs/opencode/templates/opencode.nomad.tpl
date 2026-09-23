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

    task "opencode" {
      driver = "docker"

      config {
        image        = "[[ var "image" . ]]"
        network_mode = "host"
        ports        = ["http"]
        args         = ["serve", "--hostname", "0.0.0.0", "--port", "[[ var "port" . ]]"]
        mount {
          type   = "volume"
          target = "/root/.config/opencode"
          source = "[[ var "config_volume" . ]]"
        }
        mount {
          type   = "volume"
          target = "/root/.local/share/opencode"
          source = "[[ var "data_volume" . ]]"
        }
      }

      env {
        [[- if ne (var "anthropic_api_key" .) "" ]]
        ANTHROPIC_API_KEY = "[[ var "anthropic_api_key" . ]]"
        [[- end ]]
        [[- if ne (var "openai_api_key" .) "" ]]
        OPENAI_API_KEY = "[[ var "openai_api_key" . ]]"
        [[- end ]]
      }

      resources {
        cpu    = [[ (var "resources" .).cpu ]]
        memory = [[ (var "resources" .).memory ]]
      }
    }
  }
}
