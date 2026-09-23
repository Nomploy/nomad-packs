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
        static = 3306
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
        args    = ["-c", "mkdir -p /var/www/html && chown -R [[ var "uid" . ]]:[[ var "uid" . ]] /var/www/html"]
        mount {
          type   = "volume"
          target = "/var/www/html"
          source = "[[ var "data_volume" . ]]"
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

        mount {
          type   = "volume"
          source = "[[ var "db_data_volume" . ]]"
          target = "/var/lib/mysql"
        }
      }

      env {
        MARIADB_DATABASE      = "matomo"
        MARIADB_USER          = "matomo"
        MARIADB_PASSWORD      = "[[ var "db_password" . ]]"
        MARIADB_ROOT_PASSWORD = "[[ var "db_password" . ]]"
      }

      resources {
        cpu    = [[ (var "mariadb_resources" .).cpu ]]
        memory = [[ (var "mariadb_resources" .).memory ]]
      }
    }

    task "matomo" {
      driver = "docker"

      config {
        image        = "[[ var "image" . ]]"
        network_mode = "host"
        ports        = ["http"]
        mount {
          type   = "volume"
          target = "/var/www/html"
          source = "[[ var "data_volume" . ]]"
        }
      }

      env {
        MATOMO_DATABASE_HOST      = "127.0.0.1"
        MATOMO_DATABASE_ADAPTER   = "mysql"
        MATOMO_DATABASE_TABLES_PREFIX = "matomo_"
        MATOMO_DATABASE_USERNAME  = "matomo"
        MATOMO_DATABASE_PASSWORD  = "[[ var "db_password" . ]]"
        MATOMO_DATABASE_DBNAME    = "matomo"
      }

      resources {
        cpu    = [[ (var "resources" .).cpu ]]
        memory = [[ (var "resources" .).memory ]]
      }
    }
  }
}
