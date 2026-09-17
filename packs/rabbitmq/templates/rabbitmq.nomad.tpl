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
      port "amqp" {
        static = [[ var "amqp_port" . ]]
      }
      port "management" {
        static = [[ var "management_port" . ]]
      }
    }

    service {
      name     = "[[ var "job_name" . ]]"
      provider = "nomad"
      port     = "amqp"
    }

    service {
      name     = "[[ var "job_name" . ]]-management"
      provider = "nomad"
      port     = "management"
    }

    restart {
      attempts = 3
      interval = "5m"
      delay    = "15s"
      mode     = "delay"
    }

    task "rabbitmq" {
      driver = "docker"

      config {
        image        = "[[ var "image" . ]]"
        network_mode = "host"
        ports        = ["amqp", "management"]

        mount {
          type   = "volume"
          source = "[[ var "data_volume" . ]]"
          target = "/var/lib/rabbitmq"
        }
      }

      env {
        # Stable node name → stable Mnesia data dir across reschedules. Without
        # this, a new container hostname would orphan the old data directory.
        RABBITMQ_NODENAME    = "rabbit@localhost"
        RABBITMQ_CONFIG_FILE = "/local/rabbitmq"
      }

      # Ports + bootstrap admin, set via config (so both ports are configurable).
      template {
        destination = "local/rabbitmq.conf"
        data        = <<EOH
default_user = [[ var "default_user" . ]]
default_pass = [[ var "default_password" . ]]
listeners.tcp.default = [[ var "amqp_port" . ]]
management.tcp.port = [[ var "management_port" . ]]
EOH
      }

      resources {
        cpu    = [[ (var "resources" .).cpu ]]
        memory = [[ (var "resources" .).memory ]]
      }
    }
  }
}
