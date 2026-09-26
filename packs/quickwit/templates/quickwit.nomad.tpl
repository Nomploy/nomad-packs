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

    # Make the data volume writable regardless of the image's runtime user.
    task "init" {
      driver = "docker"

      lifecycle {
        hook    = "prestart"
        sidecar = false
      }

      config {
        image   = "busybox:latest"
        command = "sh"
        args    = ["-c", "chmod -R 0777 /quickwit/qwdata"]

        mount {
          type   = "volume"
          source = "[[ var "data_volume" . ]]"
          target = "/quickwit/qwdata"
        }
      }

      resources {
        cpu    = 50
        memory = 64
      }
    }

    task "quickwit" {
      driver = "docker"

      config {
        image        = "[[ var "image" . ]]"
        network_mode = "host"
        args         = ["run"]
        ports        = ["http"]
        mount {
          type   = "volume"
          target = "/quickwit/qwdata"
          source = "[[ var "data_volume" . ]]"
        }
      }

      env {
        QW_DATA_DIR           = "/quickwit/qwdata"
        QW_LISTEN_ADDRESS     = "0.0.0.0"
        QW_REST_LISTEN_PORT   = "[[ var "port" . ]]"
      }

      resources {
        cpu    = [[ (var "resources" .).cpu ]]
        memory = [[ (var "resources" .).memory ]]
      }
    }
  }
}
