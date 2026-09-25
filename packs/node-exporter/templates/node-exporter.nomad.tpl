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
      port "metrics" {
        static = [[ var "port" . ]]
      }
    }

    service {
      name     = "[[ var "job_name" . ]]"
      provider = "nomad"
      port     = "metrics"

      check {
        type     = "http"
        path     = "/metrics"
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

    task "node-exporter" {
      driver = "docker"

      config {
        image        = "[[ var "image" . ]]"
        network_mode = "host"
        pid_mode     = "host"
        ports        = ["metrics"]
        args = [
          "--path.rootfs=/host",
          "--web.listen-address=:[[ var "port" . ]]",
          "--collector.filesystem.mount-points-exclude=^/(sys|proc|dev|host|etc)($$|/)",
        ]

        mount {
          type     = "bind"
          source   = "/"
          target   = "/host"
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
