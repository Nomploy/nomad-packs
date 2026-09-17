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
      port "client" {
        static = [[ var "client_port" . ]]
      }
      port "monitoring" {
        static = [[ var "monitoring_port" . ]]
      }
    }

    service {
      name     = "[[ var "job_name" . ]]"
      provider = "nomad"
      port     = "client"
    }

    restart {
      attempts = 3
      interval = "5m"
      delay    = "15s"
      mode     = "delay"
    }

    task "nats" {
      driver = "docker"

      config {
        image        = "[[ var "image" . ]]"
        network_mode = "host"
        ports        = ["client", "monitoring"]

        args = [
          "-p", "[[ var "client_port" . ]]",
          "-m", "[[ var "monitoring_port" . ]]",
          [[- if var "jetstream" . ]]
          "-js",
          "-sd", "/data",
          [[- end ]]
          [[- if ne (var "auth_token" .) "" ]]
          "--auth", "[[ var "auth_token" . ]]",
          [[- end ]]
        ]

        [[- if var "jetstream" . ]]
        # JetStream store on a persistent volume. NATS runs as root, so a fresh
        # volume is writable.
        mount {
          type   = "volume"
          source = "[[ var "data_volume" . ]]"
          target = "/data"
        }
        [[- end ]]
      }

      resources {
        cpu    = [[ (var "resources" .).cpu ]]
        memory = [[ (var "resources" .).memory ]]
      }
    }
  }
}
