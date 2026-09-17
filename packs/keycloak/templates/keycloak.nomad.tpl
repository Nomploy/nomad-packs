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

  # All-in-one: Postgres starts first (prestart sidecar) and shares the host
  # network namespace, so Keycloak reaches it on 127.0.0.1. Keycloak runs its DB
  # migrations automatically on start; if Postgres isn't ready yet it exits and
  # Nomad restarts it until the DB is up. count stays 1 (local Postgres volume).
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
      attempts = 5
      interval = "10m"
      delay    = "15s"
      mode     = "delay"
    }

    # --- PostgreSQL (prestart sidecar) ------------------------------------
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
        POSTGRES_DB       = "keycloak"
        POSTGRES_USER     = "keycloak"
        POSTGRES_PASSWORD = "[[ var "db_password" . ]]"
        PGPORT            = "[[ var "db_port" . ]]"
      }

      resources {
        cpu    = [[ (var "postgres_resources" .).cpu ]]
        memory = [[ (var "postgres_resources" .).memory ]]
      }
    }

    # --- Keycloak (main) --------------------------------------------------
    task "keycloak" {
      driver = "docker"

      config {
        image        = "[[ var "image" . ]]"
        network_mode = "host"
        ports        = ["http"]
        args         = ["start"]
      }

      env {
        KC_DB          = "postgres"
        KC_DB_URL      = "jdbc:postgresql://127.0.0.1:[[ var "db_port" . ]]/keycloak"
        KC_DB_USERNAME = "keycloak"
        KC_DB_PASSWORD = "[[ var "db_password" . ]]"

        KC_HTTP_ENABLED = "true"
        KC_HTTP_PORT    = "[[ var "port" . ]]"
        KC_PROXY_HEADERS = "xforwarded"
        [[- if ne (var "hostname" .) "" ]]
        KC_HOSTNAME        = "[[ var "hostname" . ]]"
        KC_HOSTNAME_STRICT = "true"
        [[- else ]]
        KC_HOSTNAME_STRICT = "false"
        [[- end ]]

        KC_BOOTSTRAP_ADMIN_USERNAME = "[[ var "admin_user" . ]]"
        KC_BOOTSTRAP_ADMIN_PASSWORD = "[[ var "admin_password" . ]]"
      }

      resources {
        cpu    = [[ (var "keycloak_resources" .).cpu ]]
        memory = [[ (var "keycloak_resources" .).memory ]]
      }
    }
  }
}
