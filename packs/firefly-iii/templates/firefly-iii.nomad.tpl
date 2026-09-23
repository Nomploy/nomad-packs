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

    task "init" {
      driver = "docker"

      lifecycle {
        hook = "prestart"
      }

      config {
        image   = "busybox:stable"
        command = "sh"
        args    = ["-c", "mkdir -p /upload && chown -R [[ var "uid" . ]]:[[ var "uid" . ]] /upload"]
        mount {
          type   = "volume"
          target = "/upload"
          source = "[[ var "upload_volume" . ]]"
        }
      }

      resources {
        cpu    = 50
        memory = 32
      }
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
        MARIADB_DATABASE      = "firefly"
        MARIADB_USER          = "firefly"
        MARIADB_PASSWORD      = "[[ var "db_password" . ]]"
        MARIADB_ROOT_PASSWORD = "[[ var "db_password" . ]]"
      }

      resources {
        cpu    = [[ (var "mariadb_resources" .).cpu ]]
        memory = [[ (var "mariadb_resources" .).memory ]]
      }
    }

    task "firefly" {
      driver = "docker"

      config {
        image        = "[[ var "image" . ]]"
        network_mode = "host"
        ports        = ["http"]
        mount {
          type   = "volume"
          target = "/var/www/html/storage/upload"
          source = "[[ var "upload_volume" . ]]"
        }
      }

      env {
        APP_KEY       = "[[ var "app_key" . ]]"
        APP_URL       = "[[ if ne (var "app_url" .) "" ]][[ var "app_url" . ]][[ else ]]http://localhost:[[ var "port" . ]][[ end ]]"
        DB_CONNECTION = "mysql"
        DB_HOST       = "127.0.0.1"
        DB_PORT       = "[[ var "db_port" . ]]"
        DB_DATABASE   = "firefly"
        DB_USERNAME   = "firefly"
        DB_PASSWORD   = "[[ var "db_password" . ]]"
        TZ            = "Etc/UTC"
      }

      resources {
        cpu    = [[ (var "resources" .).cpu ]]
        memory = [[ (var "resources" .).memory ]]
      }
    }
  }
}
