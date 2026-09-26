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

    # chown the data volume so Etherpad (uid 5001) can write its database.
    task "init" {
      driver = "docker"

      lifecycle {
        hook    = "prestart"
        sidecar = false
      }

      config {
        image   = "busybox:latest"
        command = "sh"
        args    = ["-c", "chown -R 5001:5001 /opt/etherpad-lite/var"]

        mount {
          type   = "volume"
          source = "[[ var "data_volume" . ]]"
          target = "/opt/etherpad-lite/var"
        }
      }

      resources {
        cpu    = 50
        memory = 64
      }
    }

    task "etherpad" {
      driver = "docker"

      config {
        image        = "[[ var "image" . ]]"
        network_mode = "host"
        ports        = ["http"]
        mount {
          type   = "volume"
          target = "/opt/etherpad-lite/var"
          source = "[[ var "data_volume" . ]]"
        }
      }

      env {
        NODE_ENV    = "production"
        DB_TYPE     = "sqlite"
        DB_FILENAME = "/opt/etherpad-lite/var/etherpad.db"
        [[- if ne (var "admin_password" .) "" ]]
        ADMIN_PASSWORD = "[[ var "admin_password" . ]]"
        [[- end ]]
      }

      resources {
        cpu    = [[ (var "resources" .).cpu ]]
        memory = [[ (var "resources" .).memory ]]
      }
    }
  }
}
