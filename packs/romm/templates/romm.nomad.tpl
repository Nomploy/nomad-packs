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

    task "mariadb" {
      driver = "docker"

      lifecycle {
        hook    = "prestart"
        sidecar = true
      }

      config {
        image        = "[[ var "mariadb_image" . ]]"
        network_mode = "host"
        ports        = ["db"]
        args         = ["--port=[[ var "db_port" . ]]"]

        mount {
          type   = "volume"
          source = "[[ var "db_data_volume" . ]]"
          target = "/var/lib/mysql"
        }
      }

      env {
        MARIADB_ROOT_PASSWORD = "[[ var "db_root_password" . ]]"
        MARIADB_DATABASE      = "romm"
        MARIADB_USER          = "romm"
        MARIADB_PASSWORD      = "[[ var "db_password" . ]]"
      }

      resources {
        cpu    = [[ (var "db_resources" .).cpu ]]
        memory = [[ (var "db_resources" .).memory ]]
      }
    }

    task "romm" {
      driver = "docker"

      config {
        image        = "[[ var "image" . ]]"
        network_mode = "host"
        ports        = ["http"]

        mount {
          type   = "volume"
          source = "[[ var "resources_volume" . ]]"
          target = "/romm/resources"
        }
        mount {
          type   = "volume"
          source = "[[ var "redis_volume" . ]]"
          target = "/romm/redis-data"
        }
        mount {
          type   = "volume"
          source = "[[ var "library_volume" . ]]"
          target = "/romm/library"
        }
        mount {
          type   = "volume"
          source = "[[ var "assets_volume" . ]]"
          target = "/romm/assets"
        }
        mount {
          type   = "volume"
          source = "[[ var "config_volume" . ]]"
          target = "/romm/config"
        }
      }

      env {
        ROMM_DB_DRIVER      = "mariadb"
        DB_HOST             = "127.0.0.1"
        DB_PORT             = "[[ var "db_port" . ]]"
        DB_NAME             = "romm"
        DB_USER             = "romm"
        DB_PASSWD           = "[[ var "db_password" . ]]"
        ROMM_AUTH_SECRET_KEY = "[[ var "auth_secret_key" . ]]"
        IGDB_CLIENT_ID      = "[[ var "igdb_client_id" . ]]"
        IGDB_CLIENT_SECRET  = "[[ var "igdb_client_secret" . ]]"
      }

      resources {
        cpu    = [[ (var "resources" .).cpu ]]
        memory = [[ (var "resources" .).memory ]]
      }
    }
  }
}
