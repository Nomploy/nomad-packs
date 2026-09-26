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
      port "peer" {
        static = [[ var "peer_port" . ]]
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

    task "transmission" {
      driver = "docker"

      config {
        image        = "[[ var "image" . ]]"
        network_mode = "host"
        ports        = ["http", "peer"]
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
        mount {
          type   = "volume"
          target = "/watch"
          source = "[[ var "watch_volume" . ]]"
        }
      }

      env {
        PUID          = "[[ var "puid" . ]]"
        PGID          = "[[ var "pgid" . ]]"
        TZ            = "[[ var "tz" . ]]"
        PEERPORT      = "[[ var "peer_port" . ]]"
      }

      resources {
        cpu    = [[ (var "resources" .).cpu ]]
        memory = [[ (var "resources" .).memory ]]
      }
    }
  }
}
