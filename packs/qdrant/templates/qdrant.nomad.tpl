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
      port "grpc" {
        static = [[ var "grpc_port" . ]]
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

    task "qdrant" {
      driver = "docker"

      config {
        image        = "[[ var "image" . ]]"
        network_mode = "host"
        ports        = ["http", "grpc"]

        mount {
          type   = "volume"
          source = "[[ var "data_volume" . ]]"
          target = "/qdrant/storage"
        }
      }

      env {
        QDRANT__SERVICE__HTTP_PORT = "[[ var "http_port" . ]]"
        QDRANT__SERVICE__GRPC_PORT = "[[ var "grpc_port" . ]]"
        [[- if ne (var "api_key" .) "" ]]
        QDRANT__SERVICE__API_KEY   = "[[ var "api_key" . ]]"
        [[- end ]]
      }

      resources {
        cpu    = [[ (var "resources" .).cpu ]]
        memory = [[ (var "resources" .).memory ]]
      }
    }
  }
}
