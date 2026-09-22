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

  # All-in-one: Postgres + Redis start first (prestart sidecars); the authentik
  # server and worker both connect to them on 127.0.0.1. The server runs DB
  # migrations on start; a cold DB is self-healed by the restart block. count 1.
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
      port "redis" {
        static = [[ var "redis_port" . ]]
      }
    }

    service {
      name     = "[[ var "job_name" . ]]"
      provider = "nomad"
      port     = "http"
    }

    restart {
      attempts = 5
      interval = "10m"
      delay    = "20s"
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
        POSTGRES_DB       = "authentik"
        POSTGRES_USER     = "authentik"
        POSTGRES_PASSWORD = "[[ var "db_password" . ]]"
        PGPORT            = "[[ var "db_port" . ]]"
      }

      resources {
        cpu    = [[ (var "postgres_resources" .).cpu ]]
        memory = [[ (var "postgres_resources" .).memory ]]
      }
    }

    task "redis" {
      driver = "docker"

      lifecycle {
        hook    = "prestart"
        sidecar = true
      }

      config {
        image        = "[[ var "redis_image" . ]]"
        network_mode = "host"
        ports        = ["redis"]
        args         = ["redis-server", "--port", "[[ var "redis_port" . ]]"]
      }

      resources {
        cpu    = 100
        memory = 128
      }
    }

    task "server" {
      driver = "docker"

      config {
        image        = "[[ var "image" . ]]"
        network_mode = "host"
        ports        = ["http"]
        args         = ["server"]
      }

      env {
        AUTHENTIK_SECRET_KEY          = "[[ var "secret_key" . ]]"
        AUTHENTIK_LISTEN__HTTP        = "0.0.0.0:[[ var "port" . ]]"
        AUTHENTIK_POSTGRESQL__HOST    = "127.0.0.1"
        AUTHENTIK_POSTGRESQL__PORT    = "[[ var "db_port" . ]]"
        AUTHENTIK_POSTGRESQL__USER    = "authentik"
        AUTHENTIK_POSTGRESQL__NAME    = "authentik"
        AUTHENTIK_POSTGRESQL__PASSWORD = "[[ var "db_password" . ]]"
        AUTHENTIK_REDIS__HOST         = "127.0.0.1"
        AUTHENTIK_REDIS__PORT         = "[[ var "redis_port" . ]]"
        [[- if ne (var "bootstrap_password" .) "" ]]
        AUTHENTIK_BOOTSTRAP_PASSWORD  = "[[ var "bootstrap_password" . ]]"
        AUTHENTIK_BOOTSTRAP_EMAIL     = "[[ var "bootstrap_email" . ]]"
        [[- end ]]
      }

      resources {
        cpu    = [[ (var "server_resources" .).cpu ]]
        memory = [[ (var "server_resources" .).memory ]]
      }
    }

    task "worker" {
      driver = "docker"

      config {
        image        = "[[ var "image" . ]]"
        network_mode = "host"
        args         = ["worker"]
      }

      env {
        AUTHENTIK_SECRET_KEY          = "[[ var "secret_key" . ]]"
        AUTHENTIK_POSTGRESQL__HOST    = "127.0.0.1"
        AUTHENTIK_POSTGRESQL__PORT    = "[[ var "db_port" . ]]"
        AUTHENTIK_POSTGRESQL__USER    = "authentik"
        AUTHENTIK_POSTGRESQL__NAME    = "authentik"
        AUTHENTIK_POSTGRESQL__PASSWORD = "[[ var "db_password" . ]]"
        AUTHENTIK_REDIS__HOST         = "127.0.0.1"
        AUTHENTIK_REDIS__PORT         = "[[ var "redis_port" . ]]"
        [[- if ne (var "bootstrap_password" .) "" ]]
        AUTHENTIK_BOOTSTRAP_PASSWORD  = "[[ var "bootstrap_password" . ]]"
        AUTHENTIK_BOOTSTRAP_EMAIL     = "[[ var "bootstrap_email" . ]]"
        [[- end ]]
      }

      resources {
        cpu    = [[ (var "worker_resources" .).cpu ]]
        memory = [[ (var "worker_resources" .).memory ]]
      }
    }
  }
}
