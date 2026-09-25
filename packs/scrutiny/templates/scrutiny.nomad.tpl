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

    task "scrutiny" {
      driver = "docker"

      config {
        image        = "[[ var "image" . ]]"
        network_mode = "host"
        ports        = ["http"]

        cap_add = [[ var "cap_add" . | toStringList ]]

        devices = [
          [[- range $d := var "disks" . ]]
          {
            host_path      = "[[ $d ]]"
            container_path = "[[ $d ]]"
          },
          [[- end ]]
        ]

        mount {
          type   = "volume"
          source = "[[ var "data_volume" . ]]"
          target = "/opt/scrutiny/config"
        }
        mount {
          type   = "volume"
          source = "[[ var "influx_volume" . ]]"
          target = "/opt/scrutiny/influxdb"
        }

        # Lets the collector resolve device metadata (model, serial).
        mount {
          type     = "bind"
          source   = "/run/udev"
          target   = "/run/udev"
          readonly = true
        }
      }

      env {
        SCRUTINY_WEB_LISTEN_PORT = "[[ var "port" . ]]"
      }

      resources {
        cpu    = [[ (var "resources" .).cpu ]]
        memory = [[ (var "resources" .).memory ]]
      }
    }
  }
}
