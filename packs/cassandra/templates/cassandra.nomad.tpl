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
      port "cql" {
        static = [[ var "port" . ]]
      }
      port "internode" {
        static = [[ var "internode_port" . ]]
      }
    }

    service {
      name     = "[[ var "job_name" . ]]"
      provider = "nomad"
      port     = "cql"
    }

    restart {
      attempts = 3
      interval = "5m"
      delay    = "15s"
      mode     = "delay"
    }

    task "cassandra" {
      driver = "docker"

      config {
        image        = "[[ var "image" . ]]"
        network_mode = "host"
        ports        = ["cql", "internode"]

        mount {
          type   = "volume"
          source = "[[ var "data_volume" . ]]"
          target = "/var/lib/cassandra"
        }
      }

      env {
        CASSANDRA_CLUSTER_NAME = "[[ var "cluster_name" . ]]"
        MAX_HEAP_SIZE          = "[[ var "max_heap_size" . ]]"
        HEAP_NEWSIZE           = "[[ var "heap_newsize" . ]]"
      }

      resources {
        cpu    = [[ (var "resources" .).cpu ]]
        memory = [[ (var "resources" .).memory ]]
      }
    }
  }
}
