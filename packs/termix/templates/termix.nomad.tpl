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
      port "guacd" {
        static = [[ var "guacd_port" . ]]
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

    task "guacd" {
      driver = "docker"

      lifecycle {
        hook    = "prestart"
        sidecar = true
      }

      config {
        image        = "[[ var "guacd_image" . ]]"
        network_mode = "host"
        ports        = ["guacd"]

        mount {
          type   = "volume"
          source = "[[ var "data_volume" . ]]"
          target = "/termix-data"
        }
      }

      resources {
        cpu    = [[ (var "guacd_resources" .).cpu ]]
        memory = [[ (var "guacd_resources" .).memory ]]
      }
    }

    task "termix" {
      driver = "docker"

      config {
        image        = "[[ var "image" . ]]"
        network_mode = "host"
        ports        = ["http"]

        mount {
          type   = "volume"
          source = "[[ var "data_volume" . ]]"
          target = "/app/data"
        }
      }

      env {
        PORT                 = "[[ var "port" . ]]"
        GUACD_HOST           = "127.0.0.1"
        GUACD_TUNNEL_HOST    = "127.0.0.1"
        GUACD_RECORDING_PATH = "/termix-data/session_recordings/guacamole"
        GUACD_DRIVE_PATH     = "/termix-data/rdp-drive"
      }

      resources {
        cpu    = [[ (var "resources" .).cpu ]]
        memory = [[ (var "resources" .).memory ]]
      }
    }
  }
}
