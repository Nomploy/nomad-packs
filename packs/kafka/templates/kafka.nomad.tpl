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
      port "client" {
        static = [[ var "port" . ]]
      }
      port "controller" {
        static = [[ var "controller_port" . ]]
      }
    }

    service {
      name     = "[[ var "job_name" . ]]"
      provider = "nomad"
      port     = "client"
    }

    restart {
      attempts = 3
      interval = "5m"
      delay    = "15s"
      mode     = "delay"
    }

    task "kafka" {
      driver = "docker"

      config {
        image        = "[[ var "image" . ]]"
        network_mode = "host"
        ports        = ["client", "controller"]

        mount {
          type   = "volume"
          source = "[[ var "data_volume" . ]]"
          target = "/var/lib/kafka/data"
        }
      }

      env {
        KAFKA_NODE_ID                                  = "1"
        KAFKA_PROCESS_ROLES                            = "broker,controller"
        KAFKA_CONTROLLER_QUORUM_VOTERS                 = "1@localhost:[[ var "controller_port" . ]]"
        KAFKA_LISTENERS                                = "PLAINTEXT://:[[ var "port" . ]],CONTROLLER://:[[ var "controller_port" . ]]"
        KAFKA_ADVERTISED_LISTENERS                     = "PLAINTEXT://[[ var "advertised_host" . ]]:[[ var "port" . ]]"
        KAFKA_CONTROLLER_LISTENER_NAMES                = "CONTROLLER"
        KAFKA_LISTENER_SECURITY_PROTOCOL_MAP           = "CONTROLLER:PLAINTEXT,PLAINTEXT:PLAINTEXT"
        KAFKA_INTER_BROKER_LISTENER_NAME               = "PLAINTEXT"
        KAFKA_OFFSETS_TOPIC_REPLICATION_FACTOR         = "1"
        KAFKA_TRANSACTION_STATE_LOG_REPLICATION_FACTOR = "1"
        KAFKA_TRANSACTION_STATE_LOG_MIN_ISR            = "1"
        KAFKA_GROUP_INITIAL_REBALANCE_DELAY_MS         = "0"
        KAFKA_NUM_PARTITIONS                           = "1"
        KAFKA_LOG_DIRS                                 = "/var/lib/kafka/data"
      }

      resources {
        cpu    = [[ (var "resources" .).cpu ]]
        memory = [[ (var "resources" .).memory ]]
      }
    }
  }
}
