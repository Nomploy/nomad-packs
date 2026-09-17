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

  # All-in-one: one group, one alloc. MySQL and Redis start first (prestart
  # sidecars) and share the host network namespace with Fleet, so Fleet reaches
  # them on 127.0.0.1. count stays 1 — a second alloc would spin up its own
  # MySQL/Redis and fight over the same named volumes. Scale Fleet horizontally
  # by moving to external MySQL/Redis instead.
  group "[[ var "job_name" . ]]" {
    count = 1

    network {
      mode = "host"
      port "http" {
        static = [[ var "port" . ]]
      }
      port "mysql" {
        static = [[ var "mysql_port" . ]]
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
      attempts = 3
      interval = "5m"
      delay    = "15s"
      mode     = "delay"
    }

    # --- MySQL (prestart sidecar) -----------------------------------------
    task "mysql" {
      driver = "docker"

      lifecycle {
        hook    = "prestart"
        sidecar = true
      }

      config {
        image        = "[[ var "mysql_image" . ]]"
        network_mode = "host"
        ports        = ["mysql"]
        args         = ["--port=[[ var "mysql_port" . ]]"]

        # Fresh named volume inherits the image's /var/lib/mysql ownership, so
        # MySQL (uid 999) can write it — unlike an ephemeral alloc-relative bind.
        mount {
          type   = "volume"
          source = "[[ var "mysql_data_volume" . ]]"
          target = "/var/lib/mysql"
        }
      }

      env {
        MYSQL_ROOT_PASSWORD = "[[ var "mysql_root_password" . ]]"
        MYSQL_DATABASE      = "[[ var "mysql_database" . ]]"
        MYSQL_USER          = "[[ var "mysql_username" . ]]"
        MYSQL_PASSWORD      = "[[ var "mysql_password" . ]]"
      }

      resources {
        cpu    = [[ (var "mysql_resources" .).cpu ]]
        memory = [[ (var "mysql_resources" .).memory ]]
      }
    }

    # --- Redis (prestart sidecar) -----------------------------------------
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
        args         = ["redis-server", "--appendonly", "yes", "--port", "[[ var "redis_port" . ]]"]

        mount {
          type   = "volume"
          source = "[[ var "redis_data_volume" . ]]"
          target = "/data"
        }
      }

      resources {
        cpu    = [[ (var "redis_resources" .).cpu ]]
        memory = [[ (var "redis_resources" .).memory ]]
      }
    }

    # --- Fleet server (main) ----------------------------------------------
    task "fleet" {
      driver = "docker"

      config {
        image        = "[[ var "fleet_image" . ]]"
        network_mode = "host"
        ports        = ["http"]

        # Wait for MySQL to accept connections, run migrations, then serve.
        # `fleet prepare db` is idempotent, so retrying on a cold DB is safe.
        entrypoint = ["sh", "-c"]
        args = [
          "until /usr/bin/fleet prepare db --no-prompt; do echo 'waiting for mysql...'; sleep 3; done && exec /usr/bin/fleet serve",
        ]
      }

      env {
        FLEET_MYSQL_ADDRESS  = "127.0.0.1:[[ var "mysql_port" . ]]"
        FLEET_MYSQL_DATABASE = "[[ var "mysql_database" . ]]"
        FLEET_MYSQL_USERNAME = "[[ var "mysql_username" . ]]"
        FLEET_MYSQL_PASSWORD = "[[ var "mysql_password" . ]]"

        FLEET_REDIS_ADDRESS = "127.0.0.1:[[ var "redis_port" . ]]"

        FLEET_SERVER_ADDRESS = "0.0.0.0:[[ var "port" . ]]"
        FLEET_SERVER_TLS     = "[[ var "server_tls" . ]]"
        [[- if ne (var "server_private_key" .) "" ]]
        FLEET_SERVER_PRIVATE_KEY = "[[ var "server_private_key" . ]]"
        [[- end ]]
      }

      resources {
        cpu    = [[ (var "fleet_resources" .).cpu ]]
        memory = [[ (var "fleet_resources" .).memory ]]
      }
    }
  }
}
