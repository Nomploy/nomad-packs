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

    task "conduit" {
      driver = "docker"

      config {
        image        = "[[ var "image" . ]]"
        network_mode = "host"
        ports        = ["http"]

        mount {
          type   = "volume"
          source = "[[ var "data_volume" . ]]"
          target = "/var/lib/matrix-conduit"
        }
      }

      env {
        CONDUIT_SERVER_NAME        = "[[ var "server_name" . ]]"
        CONDUIT_DATABASE_PATH      = "/var/lib/matrix-conduit"
        CONDUIT_DATABASE_BACKEND   = "rocksdb"
        CONDUIT_ADDRESS            = "0.0.0.0"
        CONDUIT_PORT               = "[[ var "port" . ]]"
        CONDUIT_ALLOW_REGISTRATION = "true"
        CONDUIT_REGISTRATION_TOKEN = "[[ var "registration_token" . ]]"
        CONDUIT_ALLOW_FEDERATION   = "[[ var "allow_federation" . ]]"
        CONDUIT_MAX_REQUEST_SIZE   = "20000000"
        CONDUIT_TRUSTED_SERVERS    = "[\"matrix.org\"]"
        CONDUIT_CONFIG             = ""
      }

      resources {
        cpu    = [[ (var "resources" .).cpu ]]
        memory = [[ (var "resources" .).memory ]]
      }
    }
  }
}
