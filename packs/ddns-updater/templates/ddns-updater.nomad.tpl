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

    # chown the data volume so DDNS Updater (uid 1000) can read/write config.json.
    task "init" {
      driver = "docker"

      lifecycle {
        hook    = "prestart"
        sidecar = false
      }

      config {
        image   = "busybox:latest"
        command = "sh"
        args    = ["-c", "chown -R 1000:1000 /updater/data && [ -f /updater/data/config.json ] || echo '{\"settings\":[]}' > /updater/data/config.json"]

        mount {
          type   = "volume"
          source = "[[ var "data_volume" . ]]"
          target = "/updater/data"
        }
      }

      resources {
        cpu    = 50
        memory = 64
      }
    }

    task "ddns-updater" {
      driver = "docker"

      config {
        image        = "[[ var "image" . ]]"
        network_mode = "host"
        ports        = ["http"]
        mount {
          type   = "volume"
          target = "/updater/data"
          source = "[[ var "data_volume" . ]]"
        }
      }

      env {
        LISTENING_ADDRESS = ":[[ var "port" . ]]"
        [[- if ne (var "config_json" .) "" ]]
        CONFIG = [[ var "config_json" . | toJson ]]
        [[- end ]]
      }

      resources {
        cpu    = [[ (var "resources" .).cpu ]]
        memory = [[ (var "resources" .).memory ]]
      }
    }
  }
}
