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

    # --- chown the data volume so n8n (uid 1000 / node) can write it -------
    task "init" {
      driver = "docker"

      lifecycle {
        hook    = "prestart"
        sidecar = false
      }

      config {
        image   = "busybox:latest"
        command = "sh"
        args    = ["-c", "chown -R 1000:1000 /home/node/.n8n"]

        mount {
          type   = "volume"
          source = "[[ var "data_volume" . ]]"
          target = "/home/node/.n8n"
        }
      }

      resources {
        cpu    = 50
        memory = 64
      }
    }

    # --- n8n (main) -------------------------------------------------------
    task "n8n" {
      driver = "docker"

      config {
        image        = "[[ var "image" . ]]"
        network_mode = "host"
        ports        = ["http"]

        mount {
          type   = "volume"
          source = "[[ var "data_volume" . ]]"
          target = "/home/node/.n8n"
        }
      }

      env {
        N8N_PORT          = "[[ var "port" . ]]"
        N8N_SECURE_COOKIE = "[[ var "secure_cookie" . ]]"
        GENERIC_TIMEZONE  = "[[ var "timezone" . ]]"
        TZ                = "[[ var "timezone" . ]]"
        [[- if ne (var "host" .) "" ]]
        N8N_HOST          = "[[ var "host" . ]]"
        [[- end ]]
        [[- if ne (var "webhook_url" .) "" ]]
        WEBHOOK_URL       = "[[ var "webhook_url" . ]]"
        [[- end ]]
        [[- if ne (var "encryption_key" .) "" ]]
        N8N_ENCRYPTION_KEY = "[[ var "encryption_key" . ]]"
        [[- end ]]
      }

      resources {
        cpu    = [[ (var "resources" .).cpu ]]
        memory = [[ (var "resources" .).memory ]]
      }
    }
  }
}
