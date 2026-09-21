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
      port "ui" {
        static = [[ var "ui_port" . ]]
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
      port     = "ui"
    }

    restart {
      attempts = 3
      interval = "5m"
      delay    = "15s"
      mode     = "delay"
    }

    task "jaeger" {
      driver = "docker"

      config {
        image        = "[[ var "image" . ]]"
        network_mode = "host"
        ports        = ["ui", "otlp_grpc", "otlp_http"]
        args = [
          "--query.http-server.host-port=:[[ var "ui_port" . ]]",
          "--collector.otlp.grpc.host-port=:[[ var "otlp_grpc_port" . ]]",
          "--collector.otlp.http.host-port=:[[ var "otlp_http_port" . ]]",
        ]
      }

      env {
        COLLECTOR_OTLP_ENABLED = "true"
      }

      resources {
        cpu    = [[ (var "resources" .).cpu ]]
        memory = [[ (var "resources" .).memory ]]
      }
    }
  }
}
