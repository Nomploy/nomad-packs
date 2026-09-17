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
    count = [[ var "count" . ]]

    network {
      mode = "host"
      port "db" {
        static = [[ var "port" . ]]
      }
    }

    service {
      name     = "[[ var "job_name" . ]]"
      provider = "nomad"
      port     = "db"
    }

    restart {
      attempts = 3
      interval = "5m"
      delay    = "15s"
      mode     = "delay"
    }

    task "mariadb" {
      driver = "docker"

      config {
        image        = "[[ var "image" . ]]"
        network_mode = "host"
        ports        = ["db"]
        args         = ["--port=[[ var "port" . ]]"]

        # Persistent named volume: a fresh one is initialized from the image's
        # data dir (ownership included), so MariaDB can write it — unlike an
        # ephemeral alloc-relative bind that resets on every reschedule.
        mount {
          type   = "volume"
          source = "[[ var "data_volume" . ]]"
          target = "/var/lib/mysql"
        }
      }

      env {
        MARIADB_DATABASE      = "[[ var "db_name" . ]]"
        MARIADB_USER          = "[[ var "db_user" . ]]"
        MARIADB_PASSWORD      = "[[ var "db_password" . ]]"
        MARIADB_ROOT_PASSWORD = "[[ var "root_password" . ]]"
      }

      resources {
        cpu    = [[ (var "resources" .).cpu ]]
        memory = [[ (var "resources" .).memory ]]
      }
    }
  }
}
