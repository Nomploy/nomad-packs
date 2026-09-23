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

    task "netdata" {
      driver = "docker"

      config {
        image        = "[[ var "image" . ]]"
        network_mode = "host"
        ports        = ["http"]

        cap_add      = ["SYS_PTRACE"]
        security_opt = ["apparmor=unconfined"]

        # Persistent agent data.
        mount {
          type   = "volume"
          source = "[[ var "config_volume" . ]]"
          target = "/etc/netdata"
        }
        mount {
          type   = "volume"
          source = "[[ var "lib_volume" . ]]"
          target = "/var/lib/netdata"
        }
        mount {
          type   = "volume"
          source = "[[ var "cache_volume" . ]]"
          target = "/var/cache/netdata"
        }

        # Read-only host insight: processes, kernel stats, users, and Docker containers.
        mount {
          type     = "bind"
          source   = "/proc"
          target   = "/host/proc"
          readonly = true
        }
        mount {
          type     = "bind"
          source   = "/sys"
          target   = "/host/sys"
          readonly = true
        }
        mount {
          type     = "bind"
          source   = "/etc/os-release"
          target   = "/host/etc/os-release"
          readonly = true
        }
        mount {
          type     = "bind"
          source   = "/var/run/docker.sock"
          target   = "/var/run/docker.sock"
          readonly = true
        }
      }

      env {
        NETDATA_LISTENER_PORT = "[[ var "port" . ]]"
      }

      resources {
        cpu    = [[ (var "resources" .).cpu ]]
        memory = [[ (var "resources" .).memory ]]
      }
    }
  }
}
