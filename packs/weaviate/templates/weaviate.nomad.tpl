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

    task "weaviate" {
      driver = "docker"

      config {
        image        = "[[ var "image" . ]]"
        network_mode = "host"
        ports        = ["http", "grpc"]
        args = [
          "--host", "0.0.0.0",
          "--port", "[[ var "port" . ]]",
          "--scheme", "http",
        ]
        mount {
          type   = "volume"
          target = "/var/lib/weaviate"
          source = "[[ var "data_volume" . ]]"
        }
      }

      env {
        PERSISTENCE_DATA_PATH   = "/var/lib/weaviate"
        QUERY_DEFAULTS_LIMIT    = "25"
        DEFAULT_VECTORIZER_MODULE = "none"
        ENABLE_MODULES          = ""
        CLUSTER_HOSTNAME        = "node1"
        GRPC_PORT               = "[[ var "grpc_port" . ]]"
        [[- if ne (var "api_key" .) "" ]]
        AUTHENTICATION_ANONYMOUS_ACCESS_ENABLED = "false"
        AUTHENTICATION_APIKEY_ENABLED           = "true"
        AUTHENTICATION_APIKEY_ALLOWED_KEYS      = "[[ var "api_key" . ]]"
        AUTHENTICATION_APIKEY_USERS             = "admin@nomploy.local"
        [[- else ]]
        AUTHENTICATION_ANONYMOUS_ACCESS_ENABLED = "[[ var "anonymous_access" . ]]"
        [[- end ]]
      }

      resources {
        cpu    = [[ (var "resources" .).cpu ]]
        memory = [[ (var "resources" .).memory ]]
      }
    }
  }
}
