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
      port "db" {
        static = [[ var "db_port" . ]]
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

    task "postgres" {
      driver = "docker"

      lifecycle {
        hook    = "prestart"
        sidecar = true
      }

      config {
        image        = "[[ var "postgres_image" . ]]"
        network_mode = "host"
        ports        = ["db"]

        mount {
          type   = "volume"
          source = "[[ var "db_data_volume" . ]]"
          target = "/var/lib/postgresql/data"
        }
      }

      env {
        POSTGRES_DB       = "coder"
        POSTGRES_USER     = "coder"
        POSTGRES_PASSWORD = "[[ var "db_password" . ]]"
        PGPORT            = "[[ var "db_port" . ]]"
      }

      resources {
        cpu    = [[ (var "db_resources" .).cpu ]]
        memory = [[ (var "db_resources" .).memory ]]
      }
    }

    task "coder" {
      driver = "docker"

      config {
        image        = "[[ var "image" . ]]"
        network_mode = "host"
        ports        = ["http"]

        mount {
          type   = "volume"
          source = "[[ var "home_volume" . ]]"
          target = "/home/coder"
        }
        [[- if ne (var "docker_sock" .) "" ]]
        mount {
          type   = "bind"
          source = "[[ var "docker_sock" . ]]"
          target = "/var/run/docker.sock"
        }
        [[- end ]]
      }

      env {
        CODER_HTTP_ADDRESS      = "0.0.0.0:[[ var "port" . ]]"
        CODER_ACCESS_URL        = "[[ var "access_url" . ]]"
        CODER_PG_CONNECTION_URL = "postgresql://coder:[[ var "db_password" . ]]@127.0.0.1:[[ var "db_port" . ]]/coder?sslmode=disable"
      }

      resources {
        cpu    = [[ (var "resources" .).cpu ]]
        memory = [[ (var "resources" .).memory ]]
      }
    }
  }
}
