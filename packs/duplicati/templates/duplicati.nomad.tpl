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

    task "duplicati" {
      driver = "docker"

      config {
        image        = "[[ var "image" . ]]"
        network_mode = "host"
        ports        = ["http"]

        mount {
          type   = "volume"
          source = "[[ var "config_volume" . ]]"
          target = "/config"
        }
        mount {
          type   = "volume"
          source = "[[ var "source_volume" . ]]"
          target = "/source"
        }
        mount {
          type   = "volume"
          source = "[[ var "backups_volume" . ]]"
          target = "/backups"
        }
      }

      env {
        PUID                    = "[[ var "puid" . ]]"
        PGID                    = "[[ var "pgid" . ]]"
        TZ                      = "[[ var "tz" . ]]"
        SETTINGS_ENCRYPTION_KEY = "[[ var "settings_encryption_key" . ]]"
        CLI_ARGS                = "--webservice-interface=any --webservice-port=[[ var "port" . ]]"
      }

      resources {
        cpu    = [[ (var "resources" .).cpu ]]
        memory = [[ (var "resources" .).memory ]]
      }
    }
  }
}
