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
      port "pg" {
        static = [[ var "pg_port" . ]]
      }
      port "ilp" {
        static = [[ var "ilp_port" . ]]
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

    task "questdb" {
      driver = "docker"

      config {
        image        = "[[ var "image" . ]]"
        network_mode = "host"
        ports        = ["http", "pg", "ilp"]
        mount {
          type   = "volume"
          target = "/var/lib/questdb"
          source = "[[ var "data_volume" . ]]"
        }
      }

      env {
        QDB_HTTP_BIND_TO         = "0.0.0.0:[[ var "http_port" . ]]"
        QDB_PG_NET_BIND_TO       = "0.0.0.0:[[ var "pg_port" . ]]"
        QDB_LINE_TCP_NET_BIND_TO = "0.0.0.0:[[ var "ilp_port" . ]]"
      }

      resources {
        cpu    = [[ (var "resources" .).cpu ]]
        memory = [[ (var "resources" .).memory ]]
      }
    }
  }
}
