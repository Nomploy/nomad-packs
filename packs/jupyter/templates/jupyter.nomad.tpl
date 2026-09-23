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

    # chown the work volume so the jovyan user (uid 1000 / gid 100) can write it.
    task "init" {
      driver = "docker"

      lifecycle {
        hook    = "prestart"
        sidecar = false
      }

      config {
        image   = "busybox:latest"
        command = "sh"
        args    = ["-c", "chown -R 1000:100 /home/jovyan/work"]

        mount {
          type   = "volume"
          source = "[[ var "work_volume" . ]]"
          target = "/home/jovyan/work"
        }
      }

      resources {
        cpu    = 50
        memory = 64
      }
    }

    task "jupyter" {
      driver = "docker"

      config {
        image        = "[[ var "image" . ]]"
        network_mode = "host"
        ports        = ["http"]
        args = [
          "start-notebook.py",
          "--ServerApp.ip=0.0.0.0",
          "--ServerApp.port=[[ var "port" . ]]",
        ]

        mount {
          type   = "volume"
          source = "[[ var "work_volume" . ]]"
          target = "/home/jovyan/work"
        }
      }

      env {
        JUPYTER_TOKEN      = "[[ var "token" . ]]"
        JUPYTER_ENABLE_LAB = "yes"
      }

      resources {
        cpu    = [[ (var "resources" .).cpu ]]
        memory = [[ (var "resources" .).memory ]]
      }
    }
  }
}
