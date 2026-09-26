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

    # chown volumes so YTPTube (uid 1000) can write config and downloads.
    task "init" {
      driver = "docker"

      lifecycle {
        hook    = "prestart"
        sidecar = false
      }

      config {
        image   = "busybox:latest"
        command = "sh"
        args    = ["-c", "mkdir -p /downloads/files /downloads/tmp && chown -R 1000:1000 /config /downloads"]

        mount {
          type   = "volume"
          source = "[[ var "data_volume" . ]]"
          target = "/config"
        }
        mount {
          type   = "volume"
          source = "[[ var "downloads_volume" . ]]"
          target = "/downloads"
        }
      }

      resources {
        cpu    = 50
        memory = 64
      }
    }

    task "ytptube" {
      driver = "docker"

      config {
        image        = "[[ var "image" . ]]"
        network_mode = "host"
        ports        = ["http"]
        mount {
          type   = "volume"
          target = "/config"
          source = "[[ var "data_volume" . ]]"
        }
        mount {
          type   = "volume"
          target = "/downloads"
          source = "[[ var "downloads_volume" . ]]"
        }
      }

      env {
        YTP_TEMP_PATH     = "/downloads/tmp"
        YTP_DOWNLOAD_PATH = "/downloads/files"
      }

      resources {
        cpu    = [[ (var "resources" .).cpu ]]
        memory = [[ (var "resources" .).memory ]]
      }
    }
  }
}
