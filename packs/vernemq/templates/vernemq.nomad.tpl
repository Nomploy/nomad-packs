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
      port "mqtt" {
        static = [[ var "mqtt_port" . ]]
      }
      port "http" {
        static = [[ var "http_port" . ]]
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

    task "vernemq" {
      driver = "docker"

      config {
        image        = "[[ var "image" . ]]"
        network_mode = "host"
        ports        = ["mqtt", "http"]
      }

      env {
        DOCKER_VERNEMQ_ACCEPT_EULA     = "yes"
        DOCKER_VERNEMQ_ALLOW_ANONYMOUS = "[[ var "allow_anonymous" . ]]"
        DOCKER_VERNEMQ_LISTENER__TCP__DEFAULT = "0.0.0.0:[[ var "mqtt_port" . ]]"
        DOCKER_VERNEMQ_LISTENER__HTTP__DEFAULT = "0.0.0.0:[[ var "http_port" . ]]"
      }

      resources {
        cpu    = [[ (var "resources" .).cpu ]]
        memory = [[ (var "resources" .).memory ]]
      }
    }
  }
}
