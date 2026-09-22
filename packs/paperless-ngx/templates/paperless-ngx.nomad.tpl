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
      port "redis" {
        static = [[ var "redis_port" . ]]
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

    task "redis" {
      driver = "docker"

      lifecycle {
        hook    = "prestart"
        sidecar = true
      }

      config {
        image        = "[[ var "redis_image" . ]]"
        network_mode = "host"
        ports        = ["redis"]
        args         = ["redis-server", "--port", "[[ var "redis_port" . ]]"]
      }

      resources {
        cpu    = [[ (var "redis_resources" .).cpu ]]
        memory = [[ (var "redis_resources" .).memory ]]
      }
    }

    task "paperless" {
      driver = "docker"

      config {
        image        = "[[ var "image" . ]]"
        network_mode = "host"
        ports        = ["http"]
        mount {
          type   = "volume"
          target = "/usr/src/paperless/data"
          source = "[[ var "data_volume" . ]]"
        }
        mount {
          type   = "volume"
          target = "/usr/src/paperless/media"
          source = "[[ var "media_volume" . ]]"
        }
        mount {
          type   = "volume"
          target = "/usr/src/paperless/consume"
          source = "[[ var "consume_volume" . ]]"
        }
      }

      env {
        PAPERLESS_REDIS          = "redis://127.0.0.1:[[ var "redis_port" . ]]"
        PAPERLESS_PORT           = "[[ var "port" . ]]"
        PAPERLESS_ADMIN_USER     = "[[ var "admin_user" . ]]"
        PAPERLESS_ADMIN_PASSWORD = "[[ var "admin_password" . ]]"
        PAPERLESS_SECRET_KEY     = "[[ var "secret_key" . ]]"
        PAPERLESS_TIME_ZONE      = "[[ var "timezone" . ]]"
        PAPERLESS_OCR_LANGUAGE   = "[[ var "ocr_language" . ]]"
        [[- if ne (var "url" .) "" ]]
        PAPERLESS_URL = "[[ var "url" . ]]"
        [[- end ]]
      }

      resources {
        cpu    = [[ (var "resources" .).cpu ]]
        memory = [[ (var "resources" .).memory ]]
      }
    }
  }
}
