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
      port "tcp" {
        static = [[ var "tcp_port" . ]]
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

    task "clickhouse" {
      driver = "docker"

      config {
        image        = "[[ var "image" . ]]"
        network_mode = "host"
        ports        = ["http", "tcp"]

        # ClickHouse recommends a high open-files limit.
        ulimit {
          nofile = "262144:262144"
        }

        # Custom listen ports via a config.d override.
        volumes = ["local/ports.xml:/etc/clickhouse-server/config.d/ports.xml"]

        mount {
          type   = "volume"
          source = "[[ var "data_volume" . ]]"
          target = "/var/lib/clickhouse"
        }
      }

      template {
        destination = "local/ports.xml"
        data        = <<EOH
<clickhouse>
    <http_port>[[ var "http_port" . ]]</http_port>
    <tcp_port>[[ var "tcp_port" . ]]</tcp_port>
</clickhouse>
EOH
      }

      env {
        CLICKHOUSE_DB                      = "[[ var "db_name" . ]]"
        CLICKHOUSE_USER                    = "[[ var "db_user" . ]]"
        CLICKHOUSE_PASSWORD                = "[[ var "db_password" . ]]"
        CLICKHOUSE_DEFAULT_ACCESS_MANAGEMENT = "1"
      }

      resources {
        cpu    = [[ (var "resources" .).cpu ]]
        memory = [[ (var "resources" .).memory ]]
      }
    }
  }
}
