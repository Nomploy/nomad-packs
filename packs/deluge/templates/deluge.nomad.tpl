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
      port "daemon" {
        static = [[ var "daemon_port" . ]]
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

    task "deluge" {
      driver = "docker"

      config {
        image        = "[[ var "image" . ]]"
        network_mode = "host"
        ports        = ["http", "peer", "daemon"]
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
        PUID = "[[ var "puid" . ]]"
        PGID = "[[ var "pgid" . ]]"
        TZ   = "[[ var "tz" . ]]"
      }

      resources {
        cpu    = [[ (var "resources" .).cpu ]]
        memory = [[ (var "resources" .).memory ]]
      }
    }
  }
}
