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
      port "playground" {
        static = [[ var "playground_port" . ]]
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

    # Create/upgrade the SQLite schema before the server starts.
    task "migrate" {
      driver = "docker"

      lifecycle {
        hook    = "prestart"
        sidecar = false
      }

      config {
        image        = "[[ var "image" . ]]"
        network_mode = "host"
        args         = ["migrate"]

        mount {
          type   = "volume"
          source = "[[ var "data_volume" . ]]"
          target = "/data"
        }
      }

      env {
        OPENFGA_DATASTORE_ENGINE = "sqlite"
        OPENFGA_DATASTORE_URI    = "/data/openfga.db"
      }

      resources {
        cpu    = 100
        memory = 128
      }
    }

    task "openfga" {
      driver = "docker"

      config {
        image        = "[[ var "image" . ]]"
        network_mode = "host"
        ports        = ["http", "grpc", "playground"]
        args         = ["run"]

        mount {
          type   = "volume"
          source = "[[ var "data_volume" . ]]"
          target = "/data"
        }
      }

      env {
        OPENFGA_DATASTORE_ENGINE   = "sqlite"
        OPENFGA_DATASTORE_URI      = "/data/openfga.db"
        OPENFGA_HTTP_ADDR          = "0.0.0.0:[[ var "http_port" . ]]"
        OPENFGA_GRPC_ADDR          = "0.0.0.0:[[ var "grpc_port" . ]]"
        OPENFGA_PLAYGROUND_ENABLED = "true"
        OPENFGA_PLAYGROUND_PORT    = "[[ var "playground_port" . ]]"
      }

      resources {
        cpu    = [[ (var "resources" .).cpu ]]
        memory = [[ (var "resources" .).memory ]]
      }
    }
  }
}
