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
        POSTGRES_DB       = "listmonk"
        POSTGRES_USER     = "listmonk"
        POSTGRES_PASSWORD = "[[ var "db_password" . ]]"
        PGPORT            = "[[ var "db_port" . ]]"
      }

      resources {
        cpu    = [[ (var "db_resources" .).cpu ]]
        memory = [[ (var "db_resources" .).memory ]]
      }
    }

    task "listmonk" {
      driver = "docker"

      config {
        image        = "[[ var "image" . ]]"
        network_mode = "host"
        ports        = ["http"]
        entrypoint   = ["sh", "-c", "./listmonk --install --idempotent --yes --config '' && ./listmonk --upgrade --yes --config '' && ./listmonk --config ''"]

        mount {
          type   = "volume"
          source = "[[ var "uploads_volume" . ]]"
          target = "/listmonk/uploads"
        }
      }

      env {
        TZ                       = "Etc/UTC"
        LISTMONK_app__address    = "0.0.0.0:[[ var "port" . ]]"
        LISTMONK_db__host        = "127.0.0.1"
        LISTMONK_db__port        = "[[ var "db_port" . ]]"
        LISTMONK_db__user        = "listmonk"
        LISTMONK_db__password    = "[[ var "db_password" . ]]"
        LISTMONK_db__database    = "listmonk"
        LISTMONK_db__ssl_mode    = "disable"
        LISTMONK_ADMIN_USER      = "[[ var "admin_user" . ]]"
        LISTMONK_ADMIN_PASSWORD  = "[[ var "admin_password" . ]]"
      }

      resources {
        cpu    = [[ (var "resources" .).cpu ]]
        memory = [[ (var "resources" .).memory ]]
      }
    }
  }
}
