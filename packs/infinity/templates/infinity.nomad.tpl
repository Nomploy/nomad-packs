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

    # Make the model cache writable regardless of the image's runtime user.
    task "init" {
      driver = "docker"

      lifecycle {
        hook    = "prestart"
        sidecar = false
      }

      config {
        image   = "busybox:latest"
        command = "sh"
        args    = ["-c", "chmod -R 0777 /app/.cache"]

        mount {
          type   = "volume"
          source = "[[ var "data_volume" . ]]"
          target = "/app/.cache"
        }
      }

      resources {
        cpu    = 50
        memory = 64
      }
    }

    task "infinity" {
      driver = "docker"

      config {
        image        = "[[ var "image" . ]]"
        network_mode = "host"
        ports        = ["http"]
        args = [
          "v2",
          "--engine", "optimum",
          "--model-id", "[[ var "model_id" . ]]",
          "--host", "0.0.0.0",
          "--port", "[[ var "port" . ]]",
        ]
        mount {
          type   = "volume"
          target = "/app/.cache"
          source = "[[ var "data_volume" . ]]"
        }
      }

      resources {
        cpu    = [[ (var "resources" .).cpu ]]
        memory = [[ (var "resources" .).memory ]]
      }
    }
  }
}
