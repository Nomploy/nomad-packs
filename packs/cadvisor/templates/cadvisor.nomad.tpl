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

      check {
        type     = "http"
        path     = "/healthz"
        interval = "30s"
        timeout  = "3s"
      }
    }

    restart {
      attempts = 3
      interval = "5m"
      delay    = "15s"
      mode     = "delay"
    }

    task "cadvisor" {
      driver = "docker"

      config {
        image        = "[[ var "image" . ]]"
        network_mode = "host"
        ports        = ["http"]
        args         = ["--port=[[ var "port" . ]]"]

        # Read-only access to the host and Docker for container metrics.
        mount {
          type     = "bind"
          source   = "/"
          target   = "/rootfs"
          readonly = true
        }
        mount {
          type   = "bind"
          source = "/var/run"
          target = "/var/run"
        }
        mount {
          type     = "bind"
          source   = "/sys"
          target   = "/sys"
          readonly = true
        }
        mount {
          type     = "bind"
          source   = "/var/lib/docker"
          target   = "/var/lib/docker"
          readonly = true
        }
      }

      resources {
        cpu    = [[ (var "resources" .).cpu ]]
        memory = [[ (var "resources" .).memory ]]
      }
    }
  }
}
