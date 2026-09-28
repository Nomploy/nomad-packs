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
      port "https" {
        static = [[ var "https_port" . ]]
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

    task "openhab" {
      driver = "docker"

      config {
        image        = "[[ var "image" . ]]"
        network_mode = "host"
        ports        = ["http", "https"]

        mount {
          type   = "volume"
          source = "[[ var "conf_volume" . ]]"
          target = "/openhab/conf"
        }
        mount {
          type   = "volume"
          source = "[[ var "userdata_volume" . ]]"
          target = "/openhab/userdata"
        }
        mount {
          type   = "volume"
          source = "[[ var "addons_volume" . ]]"
          target = "/openhab/addons"
        }
      }

      env {
        CRYPTO_POLICY        = "unlimited"
        OPENHAB_HTTP_PORT    = "[[ var "port" . ]]"
        OPENHAB_HTTPS_PORT   = "[[ var "https_port" . ]]"
        EXTRA_JAVA_OPTS      = "-Duser.timezone=[[ var "timezone" . ]]"
      }

      resources {
        cpu    = [[ (var "resources" .).cpu ]]
        memory = [[ (var "resources" .).memory ]]
      }
    }
  }
}
