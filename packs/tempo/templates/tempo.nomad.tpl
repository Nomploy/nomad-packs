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
      port "otlp_grpc" {
        static = [[ var "otlp_grpc_port" . ]]
      }
      port "otlp_http" {
        static = [[ var "otlp_http_port" . ]]
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

    # chown the data volume so Tempo (uid 10001) can write the WAL and blocks.
    task "init" {
      driver = "docker"

      lifecycle {
        hook    = "prestart"
        sidecar = false
      }

      config {
        image   = "busybox:latest"
        command = "sh"
        args    = ["-c", "chown -R 10001:10001 /var/tempo"]

        mount {
          type   = "volume"
          source = "[[ var "data_volume" . ]]"
          target = "/var/tempo"
        }
      }

      resources {
        cpu    = 50
        memory = 64
      }
    }

    task "tempo" {
      driver = "docker"

      config {
        image        = "[[ var "image" . ]]"
        network_mode = "host"
        args         = ["-config.file=/local/tempo.yaml"]
        ports        = ["http", "otlp_grpc", "otlp_http"]
        mount {
          type   = "volume"
          target = "/var/tempo"
          source = "[[ var "data_volume" . ]]"
        }
      }

      template {
        destination = "local/tempo.yaml"
        data        = <<-EOF
        server:
          http_listen_port: [[ var "port" . ]]

        distributor:
          receivers:
            otlp:
              protocols:
                grpc:
                  endpoint: "0.0.0.0:[[ var "otlp_grpc_port" . ]]"
                http:
                  endpoint: "0.0.0.0:[[ var "otlp_http_port" . ]]"

        ingester:
          max_block_duration: 5m

        compactor:
          compaction:
            block_retention: [[ var "block_retention" . ]]

        storage:
          trace:
            backend: local
            wal:
              path: /var/tempo/wal
            local:
              path: /var/tempo/blocks
        EOF
      }

      resources {
        cpu    = [[ (var "resources" .).cpu ]]
        memory = [[ (var "resources" .).memory ]]
      }
    }
  }
}
