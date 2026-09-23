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

    task "init" {
      driver = "docker"

      lifecycle {
        hook = "prestart"
      }

      config {
        image   = "busybox:stable"
        command = "sh"
        args    = ["-c", "mkdir -p /shiori && chown -R [[ var "uid" . ]]:[[ var "uid" . ]] /shiori"]
        mount {
          type   = "volume"
          target = "/shiori"
          source = "[[ var "data_volume" . ]]"
        }
      }

      resources {
        cpu    = 50
        memory = 32
      }
    }

    task "shiori" {
      driver = "docker"

      config {
        image        = "[[ var "image" . ]]"
        network_mode = "host"
        ports        = ["http"]
        args         = ["serve", "--address", "0.0.0.0", "--port", "[[ var "port" . ]]"]
        mount {
          type   = "volume"
          target = "/shiori"
          source = "[[ var "data_volume" . ]]"
        }
      }

      env {
        SHIORI_DIR             = "/shiori"
        SHIORI_HTTP_SECRET_KEY = "[[ var "secret_key" . ]]"
      }

      resources {
        cpu    = [[ (var "resources" .).cpu ]]
        memory = [[ (var "resources" .).memory ]]
      }
    }
  }
}
