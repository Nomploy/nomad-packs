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
      port "db" {
        static = [[ var "db_port" . ]]
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

    task "postgres" {
      driver = "docker"

      lifecycle {
        hook    = "prestart"
        sidecar = true
      }

      config {
        image        = "[[ var "postgres_image" . ]]"
        network_mode = "host"
        ports        = ["db"]

        mount {
          type   = "volume"
          source = "[[ var "db_data_volume" . ]]"
          target = "/var/lib/postgresql/data"
        }
      }

      env {
        POSTGRES_DB       = "planka"
        POSTGRES_USER     = "planka"
        POSTGRES_PASSWORD = "[[ var "db_password" . ]]"
        PGPORT            = "[[ var "db_port" . ]]"
      }

      resources {
        cpu    = [[ (var "postgres_resources" .).cpu ]]
        memory = [[ (var "postgres_resources" .).memory ]]
      }
    }

    task "planka" {
      driver = "docker"

      config {
        image        = "[[ var "image" . ]]"
        network_mode = "host"
        ports        = ["http"]
        mount {
          type   = "volume"
          target = "/app/public/user-avatars"
          source = "[[ var "avatars_volume" . ]]"
        }
        mount {
          type   = "volume"
          target = "/app/public/project-background-images"
          source = "[[ var "backgrounds_volume" . ]]"
        }
        mount {
          type   = "volume"
          target = "/app/private/attachments"
          source = "[[ var "attachments_volume" . ]]"
        }
      }

      env {
        PORT                   = "[[ var "port" . ]]"
        BASE_URL               = "[[ if ne (var "base_url" .) "" ]][[ var "base_url" . ]][[ else ]]http://localhost:[[ var "port" . ]][[ end ]]"
        DATABASE_URL           = "postgresql://planka:[[ var "db_password" . ]]@127.0.0.1:[[ var "db_port" . ]]/planka"
        SECRET_KEY             = "[[ var "secret_key" . ]]"
        TRUST_PROXY            = "true"
        DEFAULT_ADMIN_EMAIL    = "[[ var "admin_email" . ]]"
        DEFAULT_ADMIN_USERNAME = "[[ var "admin_username" . ]]"
        DEFAULT_ADMIN_PASSWORD = "[[ var "admin_password" . ]]"
        DEFAULT_ADMIN_NAME     = "[[ var "admin_name" . ]]"
      }

      resources {
        cpu    = [[ (var "resources" .).cpu ]]
        memory = [[ (var "resources" .).memory ]]
      }
    }
  }
}
