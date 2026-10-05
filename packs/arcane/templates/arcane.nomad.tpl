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

    task "arcane" {
      driver = "docker"
      user   = "root"

      config {
        image        = "[[ var "image" . ]]"
        network_mode = "host"
        ports        = ["http"]

        mount {
          type   = "bind"
          source = "[[ var "docker_socket" . ]]"
          target = "/var/run/docker.sock"
        }
        mount {
          type   = "volume"
          source = "[[ var "data_volume" . ]]"
          target = "/app/data"
        }
      }

      env {
        GIN_MODE       = "release"
        ENVIRONMENT    = "production"
        PORT           = "[[ var "port" . ]]"
        APP_URL        = "[[ var "app_url" . ]]"
        ENCRYPTION_KEY = "[[ var "encryption_key" . ]]"
        JWT_SECRET     = "[[ var "jwt_secret" . ]]"
        DATABASE_URL   = "file:data/arcane.db?_pragma=journal_mode(WAL)&_pragma=busy_timeout(2500)&_txlock=immediate"
      }

      resources {
        cpu    = [[ (var "resources" .).cpu ]]
        memory = [[ (var "resources" .).memory ]]
      }
    }
  }
}
