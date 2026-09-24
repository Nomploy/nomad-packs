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
      port "web" {
        static = [[ var "web_port" . ]]
      }
      port "slsk" {
        static = [[ var "listen_port" . ]]
      }
    }

    service {
      name     = "[[ var "job_name" . ]]"
      provider = "nomad"
      port     = "web"
    }

    restart {
      attempts = 3
      interval = "5m"
      delay    = "15s"
      mode     = "delay"
    }

    task "slskd" {
      driver = "docker"

      config {
        image        = "[[ var "image" . ]]"
        network_mode = "host"
        ports        = ["web", "slsk"]

        mount {
          type   = "volume"
          source = "[[ var "data_volume" . ]]"
          target = "/app"
        }
      }

      env {
        SLSKD_REMOTE_CONFIGURATION = "true"
        SLSKD_HTTP_PORT            = "[[ var "web_port" . ]]"
        SLSKD_SLSK_LISTEN_PORT     = "[[ var "listen_port" . ]]"
        SLSKD_SLSK_USERNAME        = "[[ var "slsk_username" . ]]"
        SLSKD_SLSK_PASSWORD        = "[[ var "slsk_password" . ]]"
      }

      resources {
        cpu    = [[ (var "resources" .).cpu ]]
        memory = [[ (var "resources" .).memory ]]
      }
    }
  }
}
