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
      port "kafka" {
        static = [[ var "kafka_port" . ]]
      }
      port "admin" {
        static = [[ var "admin_port" . ]]
      }
      port "proxy" {
        static = [[ var "proxy_port" . ]]
      }
      port "schema" {
        static = [[ var "schema_port" . ]]
      }
    }

    service {
      name     = "[[ var "job_name" . ]]"
      provider = "nomad"
      port     = "kafka"
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
        args    = ["-c", "mkdir -p /var/lib/redpanda/data && chown -R [[ var "uid" . ]]:[[ var "uid" . ]] /var/lib/redpanda/data"]
        mount {
          type   = "volume"
          target = "/var/lib/redpanda/data"
          source = "[[ var "data_volume" . ]]"
        }
      }

      resources {
        cpu    = 50
        memory = 32
      }
    }

    task "redpanda" {
      driver = "docker"

      config {
        image        = "[[ var "image" . ]]"
        network_mode = "host"
        ports        = ["kafka", "admin", "proxy", "schema"]
        args = [
          "redpanda", "start",
          "--mode", "dev-container",
          "--smp", "1",
          "--default-log-level=info",
          "--kafka-addr", "0.0.0.0:[[ var "kafka_port" . ]]",
          "--advertise-kafka-addr", "[[ var "advertise_host" . ]]:[[ var "kafka_port" . ]]",
          "--pandaproxy-addr", "0.0.0.0:[[ var "proxy_port" . ]]",
          "--advertise-pandaproxy-addr", "[[ var "advertise_host" . ]]:[[ var "proxy_port" . ]]",
          "--schema-registry-addr", "0.0.0.0:[[ var "schema_port" . ]]",
        ]
        mount {
          type   = "volume"
          target = "/var/lib/redpanda/data"
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
