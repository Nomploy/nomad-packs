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
      interval = "10m"
      delay    = "20s"
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
        POSTGRES_DB       = "khoj"
        POSTGRES_USER     = "khoj"
        POSTGRES_PASSWORD = "[[ var "db_password" . ]]"
        PGPORT            = "[[ var "db_port" . ]]"
      }

      resources {
        cpu    = [[ (var "db_resources" .).cpu ]]
        memory = [[ (var "db_resources" .).memory ]]
      }
    }

    task "server" {
      driver = "docker"

      config {
        image        = "[[ var "image" . ]]"
        network_mode = "host"
        ports        = ["http"]
        args = [
          "--host=0.0.0.0",
          "--port=[[ var "port" . ]]",
          "-vv",
          "--anonymous-mode",
          "--non-interactive",
        ]

        mount {
          type   = "volume"
          source = "[[ var "config_volume" . ]]"
          target = "/root/.khoj"
        }
        mount {
          type   = "volume"
          source = "[[ var "models_volume" . ]]"
          target = "/root/.cache/torch/sentence_transformers"
        }
        mount {
          type   = "volume"
          source = "[[ var "models_volume" . ]]"
          target = "/root/.cache/huggingface"
        }
      }

      env {
        POSTGRES_DB            = "khoj"
        POSTGRES_USER          = "khoj"
        POSTGRES_PASSWORD      = "[[ var "db_password" . ]]"
        POSTGRES_HOST          = "127.0.0.1"
        POSTGRES_PORT          = "[[ var "db_port" . ]]"
        KHOJ_DJANGO_SECRET_KEY = "[[ var "django_secret_key" . ]]"
        KHOJ_DEBUG             = "False"
        KHOJ_ADMIN_EMAIL       = "[[ var "admin_email" . ]]"
        KHOJ_ADMIN_PASSWORD    = "[[ var "admin_password" . ]]"
        [[- if ne (var "searxng_url" .) "" ]]
        KHOJ_SEARXNG_URL = "[[ var "searxng_url" . ]]"
        [[- end ]]
        [[- if ne (var "terrarium_url" .) "" ]]
        KHOJ_TERRARIUM_URL = "[[ var "terrarium_url" . ]]"
        [[- end ]]
      }

      resources {
        cpu    = [[ (var "resources" .).cpu ]]
        memory = [[ (var "resources" .).memory ]]
      }
    }
  }
}
