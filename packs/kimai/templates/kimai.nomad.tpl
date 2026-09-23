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
        args    = ["-c", "mkdir -p /data && chown -R [[ var "uid" . ]]:[[ var "uid" . ]] /data"]
        mount {
          type   = "volume"
          target = "/data"
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
        args         = ["--port=[[ var "db_port" . ]]"]

        mount {
          type   = "volume"
          source = "[[ var "db_data_volume" . ]]"
          target = "/var/lib/mysql"
        }
      }

      env {
        MARIADB_DATABASE      = "kimai"
        MARIADB_USER          = "kimai"
        MARIADB_PASSWORD      = "[[ var "db_password" . ]]"
        MARIADB_ROOT_PASSWORD = "[[ var "db_password" . ]]"
      }

      resources {
        cpu    = [[ (var "mariadb_resources" .).cpu ]]
        memory = [[ (var "mariadb_resources" .).memory ]]
      }
    }

    task "kimai" {
      driver = "docker"

      config {
        image        = "[[ var "image" . ]]"
        network_mode = "host"
        ports        = ["http"]
        mount {
          type   = "volume"
          target = "/opt/kimai/var/data"
          source = "[[ var "data_volume" . ]]"
        }
      }

      env {
        DATABASE_URL  = "mysql://kimai:[[ var "db_password" . ]]@127.0.0.1:[[ var "db_port" . ]]/kimai?charset=utf8mb4&serverVersion=11.0.0-MariaDB"
        ADMINMAIL     = "[[ var "admin_email" . ]]"
        ADMINPASS     = "[[ var "admin_password" . ]]"
        TRUSTED_HOSTS = "[[ var "trusted_hosts" . ]]"
      }

      resources {
        cpu    = [[ (var "resources" .).cpu ]]
        memory = [[ (var "resources" .).memory ]]
      }
    }
  }
}
