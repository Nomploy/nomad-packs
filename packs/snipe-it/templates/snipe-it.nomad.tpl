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

    # Make the app data volume writable regardless of the image's runtime user.
    task "init" {
      driver = "docker"

      lifecycle {
        hook    = "prestart"
        sidecar = false
      }

      config {
        image   = "busybox:latest"
        command = "sh"
        args    = ["-c", "chmod -R 0777 /var/lib/snipeit"]

        mount {
          type   = "volume"
          source = "[[ var "data_volume" . ]]"
          target = "/var/lib/snipeit"
        }
      }

      resources {
        cpu    = 50
        memory = 64
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
        args         = ["--port", "[[ var "db_port" . ]]"]

        mount {
          type   = "volume"
          source = "[[ var "db_data_volume" . ]]"
          target = "/var/lib/mysql"
        }
      }

      env {
        MARIADB_DATABASE      = "snipeit"
        MARIADB_USER          = "snipeit"
        MARIADB_PASSWORD      = "[[ var "db_password" . ]]"
        MARIADB_ROOT_PASSWORD = "[[ var "db_password" . ]]"
      }

      resources {
        cpu    = [[ (var "db_resources" .).cpu ]]
        memory = [[ (var "db_resources" .).memory ]]
      }
    }

    task "snipe-it" {
      driver = "docker"

      config {
        image        = "[[ var "image" . ]]"
        network_mode = "host"
        ports        = ["http"]
        mount {
          type   = "volume"
          target = "/var/lib/snipeit"
          source = "[[ var "data_volume" . ]]"
        }
      }

      env {
        APP_KEY             = "[[ var "app_key" . ]]"
        APP_URL             = "[[ if ne (var "base_url" .) "" ]][[ var "base_url" . ]][[ else ]]http://localhost:[[ var "port" . ]][[ end ]]"
        APP_PORT            = "[[ var "port" . ]]"
        APP_TRUSTED_PROXIES = "*"
        DB_CONNECTION       = "mysql"
        DB_HOST             = "127.0.0.1"
        DB_PORT             = "[[ var "db_port" . ]]"
        DB_DATABASE         = "snipeit"
        DB_USERNAME         = "snipeit"
        DB_PASSWORD         = "[[ var "db_password" . ]]"
      }

      resources {
        cpu    = [[ (var "resources" .).cpu ]]
        memory = [[ (var "resources" .).memory ]]
      }
    }
  }
}
