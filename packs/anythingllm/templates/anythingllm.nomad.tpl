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

    # chown the storage volume so the anythingllm user (uid 1000) can write it.
    task "init" {
      driver = "docker"

      lifecycle {
        hook    = "prestart"
        sidecar = false
      }

      config {
        image   = "busybox:latest"
        command = "sh"
        args    = ["-c", "chown -R 1000:1000 /app/server/storage"]

        mount {
          type   = "volume"
          source = "[[ var "storage_volume" . ]]"
          target = "/app/server/storage"
        }
      }

      resources {
        cpu    = 50
        memory = 64
      }
    }

    task "anythingllm" {
      driver = "docker"

      config {
        image        = "[[ var "image" . ]]"
        network_mode = "host"
        ports        = ["http"]
        cap_add      = ["SYS_ADMIN"]

        mount {
          type   = "volume"
          source = "[[ var "storage_volume" . ]]"
          target = "/app/server/storage"
        }
      }

      env {
        SERVER_PORT = "[[ var "port" . ]]"
        STORAGE_DIR = "/app/server/storage"
      }

      resources {
        cpu    = [[ (var "resources" .).cpu ]]
        memory = [[ (var "resources" .).memory ]]
      }
    }
  }
}
