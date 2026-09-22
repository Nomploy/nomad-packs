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
      port "reg" {
        static = 21115
      }
      port "main" {
        static = 21116
      }
      port "relay" {
        static = 21117
      }
      port "ws" {
        static = 21118
      }
      port "relayws" {
        static = 21119
      }
    }

    service {
      name     = "[[ var "job_name" . ]]"
      provider = "nomad"
      port     = "main"
    }

    restart {
      attempts = 3
      interval = "5m"
      delay    = "15s"
      mode     = "delay"
    }

    task "rustdesk" {
      driver = "docker"

      config {
        image        = "[[ var "image" . ]]"
        network_mode = "host"
        ports        = ["reg", "main", "relay", "ws", "relayws"]
        mount {
          type   = "volume"
          target = "/data"
          source = "[[ var "data_volume" . ]]"
        }
      }

      env {
        ENCRYPTED_ONLY = "[[ var "encrypted_only" . ]]"
        [[- if ne (var "relay_host" .) "" ]]
        RELAY = "[[ var "relay_host" . ]]:21117"
        [[- end ]]
      }

      resources {
        cpu    = [[ (var "resources" .).cpu ]]
        memory = [[ (var "resources" .).memory ]]
      }
    }
  }
}
