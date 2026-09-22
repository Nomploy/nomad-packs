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

  # All-in-one: Postgres starts first (prestart sidecar); Directus reaches it on
  # 127.0.0.1, bootstraps the schema + admin on first start. count stays 1.
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
      delay    = "20s"
      mode     = "delay"
    }

    # chown the uploads volume so Directus (uid 1000) can write files.
    task "init" {
      driver = "docker"

      lifecycle {
        hook    = "prestart"
        sidecar = false
      }

      config {
        image   = "busybox:latest"
        command = "sh"
        args    = ["-c", "chown -R 1000:1000 /directus/uploads"]

        mount {
          type   = "volume"
          source = "[[ var "uploads_volume" . ]]"
          target = "/directus/uploads"
        }
      }

      resources {
        cpu    = 50
        memory = 64
      }
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
        POSTGRES_DB       = "directus"
        POSTGRES_USER     = "directus"
        POSTGRES_PASSWORD = "[[ var "db_password" . ]]"
        PGPORT            = "[[ var "db_port" . ]]"
      }

      resources {
        cpu    = [[ (var "postgres_resources" .).cpu ]]
        memory = [[ (var "postgres_resources" .).memory ]]
      }
    }

    # --- Directus (main) --------------------------------------------------
    task "directus" {
      driver = "docker"

      config {
        image        = "[[ var "image" . ]]"
        network_mode = "host"
        ports        = ["http"]

        mount {
          type   = "volume"
          source = "[[ var "uploads_volume" . ]]"
          target = "/directus/uploads"
        }
      }

      env {
        HOST           = "0.0.0.0"
        PORT           = "[[ var "port" . ]]"
        KEY            = "[[ var "key" . ]]"
        SECRET         = "[[ var "secret" . ]]"
        ADMIN_EMAIL    = "[[ var "admin_email" . ]]"
        ADMIN_PASSWORD = "[[ var "admin_password" . ]]"
        DB_CLIENT      = "pg"
        DB_HOST        = "127.0.0.1"
        DB_PORT        = "[[ var "db_port" . ]]"
        DB_DATABASE    = "directus"
        DB_USER        = "directus"
        DB_PASSWORD    = "[[ var "db_password" . ]]"
        [[- if ne (var "public_url" .) "" ]]
        PUBLIC_URL     = "[[ var "public_url" . ]]"
        [[- end ]]
      }

      resources {
        cpu    = [[ (var "directus_resources" .).cpu ]]
        memory = [[ (var "directus_resources" .).memory ]]
      }
    }
  }
}
