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

    task "backrest" {
      driver = "docker"

      config {
        image        = "[[ var "image" . ]]"
        network_mode = "host"
        ports        = ["http"]

        mount {
          type   = "volume"
          source = "[[ var "data_volume" . ]]"
          target = "/data"
        }
        mount {
          type   = "volume"
          source = "[[ var "config_volume" . ]]"
          target = "/config"
        }
        mount {
          type   = "volume"
          source = "[[ var "cache_volume" . ]]"
          target = "/cache"
        }
        mount {
          type   = "volume"
          source = "[[ var "sources_volume" . ]]"
          target = "/userdata"
        }
      }

      env {
        BACKREST_PORT   = "0.0.0.0:[[ var "port" . ]]"
        BACKREST_DATA   = "/data"
        BACKREST_CONFIG = "/config/config.json"
        XDG_CACHE_HOME  = "/cache"
      }

      resources {
        cpu    = [[ (var "resources" .).cpu ]]
        memory = [[ (var "resources" .).memory ]]
      }
    }
  }
}
