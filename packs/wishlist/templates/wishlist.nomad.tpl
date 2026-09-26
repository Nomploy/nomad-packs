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

    # chown the volumes so Wishlist (uid 1000) can write the database and uploads.
    task "init" {
      driver = "docker"

      lifecycle {
        hook    = "prestart"
        sidecar = false
      }

      config {
        image   = "busybox:latest"
        command = "sh"
        args    = ["-c", "chown -R 1000:1000 /usr/src/app/data /usr/src/app/uploads"]

        mount {
          type   = "volume"
          source = "[[ var "data_volume" . ]]"
          target = "/usr/src/app/data"
        }
        mount {
          type   = "volume"
          source = "[[ var "uploads_volume" . ]]"
          target = "/usr/src/app/uploads"
        }
      }

      resources {
        cpu    = 50
        memory = 64
      }
    }

    task "wishlist" {
      driver = "docker"

      config {
        image        = "[[ var "image" . ]]"
        network_mode = "host"
        ports        = ["http"]
        mount {
          type   = "volume"
          target = "/usr/src/app/data"
          source = "[[ var "data_volume" . ]]"
        }
        mount {
          type   = "volume"
          target = "/usr/src/app/uploads"
          source = "[[ var "uploads_volume" . ]]"
        }
      }

      env {
        PORT             = "[[ var "port" . ]]"
        ORIGIN           = "[[ if ne (var "base_url" .) "" ]][[ var "base_url" . ]][[ else ]]http://localhost:[[ var "port" . ]][[ end ]]"
        TOKEN_TIME       = "[[ var "token_time" . ]]"
        DEFAULT_CURRENCY = "[[ var "default_currency" . ]]"
      }

      resources {
        cpu    = [[ (var "resources" .).cpu ]]
        memory = [[ (var "resources" .).memory ]]
      }
    }
  }
}
