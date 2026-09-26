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
      port "console" {
        static = [[ var "console_port" . ]]
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

    # chown the data volume so RustFS (uid 10001) can write it.
    task "init" {
      driver = "docker"

      lifecycle {
        hook    = "prestart"
        sidecar = false
      }

      config {
        image   = "busybox:latest"
        command = "sh"
        args    = ["-c", "chown -R 10001:10001 /data"]

        mount {
          type   = "volume"
          source = "[[ var "data_volume" . ]]"
          target = "/data"
        }
      }

      resources {
        cpu    = 50
        memory = 64
      }
    }

    task "rustfs" {
      driver = "docker"

      config {
        image        = "[[ var "image" . ]]"
        network_mode = "host"
        ports        = ["http", "console"]
        mount {
          type   = "volume"
          target = "/data"
          source = "[[ var "data_volume" . ]]"
        }
      }

      env {
        RUSTFS_ADDRESS         = ":[[ var "port" . ]]"
        RUSTFS_CONSOLE_ADDRESS = ":[[ var "console_port" . ]]"
        RUSTFS_CONSOLE_ENABLE  = "true"
        RUSTFS_VOLUMES         = "/data"
        RUSTFS_ACCESS_KEY      = "[[ var "access_key" . ]]"
        RUSTFS_SECRET_KEY      = "[[ var "secret_key" . ]]"
      }

      resources {
        cpu    = [[ (var "resources" .).cpu ]]
        memory = [[ (var "resources" .).memory ]]
      }
    }
  }
}
