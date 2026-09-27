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

    task "streamystats" {
      driver = "docker"

      config {
        image        = "[[ var "image" . ]]"
        network_mode = "host"
        ports        = ["http"]
        mount {
          type   = "volume"
          target = "/var/lib/postgresql/data"
          source = "[[ var "data_volume" . ]]"
        }
      }

      env {
        PORT                     = "[[ var "port" . ]]"
        POSTGRES_USER            = "postgres"
        POSTGRES_PASSWORD        = "[[ var "db_password" . ]]"
        POSTGRES_DB              = "streamystats"
        POSTGRES_HOST_AUTH_METHOD = "scram-sha-256"
        POSTGRES_INITDB_ARGS     = "--auth-host=scram-sha-256"
        DATABASE_URL             = "postgresql://postgres:[[ var "db_password" . ]]@localhost:5432/streamystats"
        SESSION_SECRET           = "[[ var "session_secret" . ]]"
      }

      resources {
        cpu    = [[ (var "resources" .).cpu ]]
        memory = [[ (var "resources" .).memory ]]
      }
    }
  }
}
