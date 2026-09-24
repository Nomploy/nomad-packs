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
      port "https" {
        static = [[ var "port" . ]]
      }
    }

    service {
      name     = "[[ var "job_name" . ]]"
      provider = "nomad"
      port     = "https"
    }

    restart {
      attempts = 3
      interval = "5m"
      delay    = "15s"
      mode     = "delay"
    }

    task "step-ca" {
      driver = "docker"

      config {
        image        = "[[ var "image" . ]]"
        network_mode = "host"
        ports        = ["https"]

        mount {
          type   = "volume"
          source = "[[ var "data_volume" . ]]"
          target = "/home/step"
        }
      }

      env {
        DOCKER_STEPCA_INIT_NAME              = "[[ var "ca_name" . ]]"
        DOCKER_STEPCA_INIT_DNS_NAMES         = "[[ var "dns_names" . ]]"
        DOCKER_STEPCA_INIT_PASSWORD          = "[[ var "ca_password" . ]]"
        DOCKER_STEPCA_INIT_ADDRESS           = "0.0.0.0:[[ var "port" . ]]"
        DOCKER_STEPCA_INIT_REMOTE_MANAGEMENT = "true"
      }

      resources {
        cpu    = [[ (var "resources" .).cpu ]]
        memory = [[ (var "resources" .).memory ]]
      }
    }
  }
}
