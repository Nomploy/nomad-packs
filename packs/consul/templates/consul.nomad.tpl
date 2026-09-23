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
        static = [[ var "http_port" . ]]
      }
      port "dns" {
        static = [[ var "dns_port" . ]]
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
        args    = ["-c", "mkdir -p /consul/data && chown -R [[ var "uid" . ]]:[[ var "uid" . ]] /consul/data"]
        mount {
          type   = "volume"
          target = "/consul/data"
          source = "[[ var "data_volume" . ]]"
        }
      }

      resources {
        cpu    = 50
        memory = 32
      }
    }

    task "consul" {
      driver = "docker"

      config {
        image        = "[[ var "image" . ]]"
        network_mode = "host"
        ports        = ["http", "dns"]
        args = [
          "agent", "-server", "-bootstrap-expect=1", "-ui",
          "-client=0.0.0.0",
          "-bind=127.0.0.1",
          "-advertise=127.0.0.1",
          "-data-dir=/consul/data",
          "-http-port=[[ var "http_port" . ]]",
          "-dns-port=[[ var "dns_port" . ]]",
        ]
        mount {
          type   = "volume"
          target = "/consul/data"
          source = "[[ var "data_volume" . ]]"
        }
      }

      resources {
        cpu    = [[ (var "resources" .).cpu ]]
        memory = [[ (var "resources" .).memory ]]
      }
    }
  }
}
