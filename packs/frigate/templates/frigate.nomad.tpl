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
      port "rtsp" {
        static = [[ var "rtsp_port" . ]]
      }
      port "webrtc" {
        static = [[ var "webrtc_port" . ]]
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

    task "init-config" {
      driver = "docker"

      lifecycle {
        hook    = "prestart"
        sidecar = false
      }

      config {
        image   = "busybox:1.36"
        command = "sh"
        args    = ["-c", "cp -n /local/config.yml /config/config.yml; chmod -R 0777 /config /media/frigate"]

        mount {
          type   = "volume"
          source = "[[ var "config_volume" . ]]"
          target = "/config"
        }
        mount {
          type   = "volume"
          source = "[[ var "media_volume" . ]]"
          target = "/media/frigate"
        }
      }

      template {
        destination = "local/config.yml"
        data        = <<-EOH
        mqtt:
          enabled: false

        # Add your cameras here. Example:
        # cameras:
        #   backyard:
        #     ffmpeg:
        #       inputs:
        #         - path: rtsp://user:pass@camera-ip:554/stream
        #           roles:
        #             - detect
        #     detect:
        #       width: 1280
        #       height: 720
        cameras: {}
        EOH
      }

      resources {
        cpu    = 100
        memory = 64
      }
    }

    task "frigate" {
      driver = "docker"

      config {
        image        = "[[ var "image" . ]]"
        network_mode = "host"
        ports        = ["http", "rtsp", "webrtc"]
        shm_size     = [[ var "shm_size" . ]]

        mount {
          type   = "volume"
          source = "[[ var "config_volume" . ]]"
          target = "/config"
        }
        mount {
          type   = "volume"
          source = "[[ var "media_volume" . ]]"
          target = "/media/frigate"
        }
        mount {
          type   = "tmpfs"
          target = "/tmp/cache"
          tmpfs_options {
            size = [[ var "cache_size" . ]]
          }
        }
      }

      resources {
        cpu    = [[ (var "resources" .).cpu ]]
        memory = [[ (var "resources" .).memory ]]
      }
    }
  }
}
