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
      port "sql" {
        static = [[ var "sql_port" . ]]
      }
      port "http" {
        static = [[ var "http_port" . ]]
      }
    }

    service {
      name     = "[[ var "job_name" . ]]"
      provider = "nomad"
      port     = "sql"
    }

    restart {
      attempts = 3
      interval = "5m"
      delay    = "15s"
      mode     = "delay"
    }

    task "cockroachdb" {
      driver = "docker"

      config {
        image        = "[[ var "image" . ]]"
        network_mode = "host"
        ports        = ["sql", "http"]
        args = [
          "start-single-node",
          "--insecure",
          "--listen-addr=0.0.0.0:[[ var "sql_port" . ]]",
          "--http-addr=0.0.0.0:[[ var "http_port" . ]]",
          "--store=/cockroach/cockroach-data",
        ]
        mount {
          type   = "volume"
          target = "/cockroach/cockroach-data"
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
