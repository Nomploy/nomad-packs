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

    task "init-perms" {
      driver = "docker"

      lifecycle {
        hook    = "prestart"
        sidecar = false
      }

      config {
        image   = "busybox:1.36"
        command = "sh"
        args    = ["-c", "chmod -R 0777 /app/db /app/uploads /app/backups"]

        mount {
          type   = "volume"
          source = "[[ var "db_volume" . ]]"
          target = "/app/db"
        }
        mount {
          type   = "volume"
          source = "[[ var "uploads_volume" . ]]"
          target = "/app/uploads"
        }
        mount {
          type   = "volume"
          source = "[[ var "backups_volume" . ]]"
          target = "/app/backups"
        }
      }

      resources {
        cpu    = 100
        memory = 64
      }
    }

    task "tududi" {
      driver = "docker"

      config {
        image        = "[[ var "image" . ]]"
        network_mode = "host"
        ports        = ["http"]

        mount {
          type   = "volume"
          source = "[[ var "db_volume" . ]]"
          target = "/app/db"
        }
        mount {
          type   = "volume"
          source = "[[ var "uploads_volume" . ]]"
          target = "/app/uploads"
        }
        mount {
          type   = "volume"
          source = "[[ var "backups_volume" . ]]"
          target = "/app/backups"
        }
      }

      env {
        TUDUDI_USER_EMAIL      = "[[ var "admin_email" . ]]"
        TUDUDI_USER_PASSWORD   = "[[ var "admin_password" . ]]"
        TUDUDI_SESSION_SECRET  = "[[ var "session_secret" . ]]"
        TUDUDI_ALLOWED_ORIGINS = "[[ var "allowed_origins" . ]]"
        TUDUDI_TRUST_PROXY     = "[[ var "trust_proxy" . ]]"
        TUDUDI_UPLOAD_PATH     = "/app/uploads"
        PORT                   = "[[ var "port" . ]]"
      }

      resources {
        cpu    = [[ (var "resources" .).cpu ]]
        memory = [[ (var "resources" .).memory ]]
      }
    }
  }
}
