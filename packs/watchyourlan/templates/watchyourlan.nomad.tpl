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

    task "watchyourlan" {
      driver = "docker"

      config {
        image        = "[[ var "image" . ]]"
        network_mode = "host"
        ports        = ["http"]

        # Raw sockets for ARP scanning of the LAN.
        cap_add = ["NET_RAW", "NET_ADMIN"]

        mount {
          type   = "volume"
          target = "/data/WatchYourLAN"
          source = "[[ var "data_volume" . ]]"
        }
      }

      env {
        IFACES  = "[[ var "ifaces" . ]]"
        PORT    = "[[ var "port" . ]]"
        TIMEOUT = "[[ var "timeout" . ]]"
        TZ      = "[[ var "tz" . ]]"
      }

      resources {
        cpu    = [[ (var "resources" .).cpu ]]
        memory = [[ (var "resources" .).memory ]]
      }
    }
  }
}
