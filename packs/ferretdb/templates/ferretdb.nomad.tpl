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

  # All-in-one: the DocumentDB-enabled PostgreSQL starts first (prestart sidecar);
  # FerretDB reaches it on 127.0.0.1 and speaks the MongoDB wire protocol to clients.
  # count stays 1 (local Postgres volume).
  group "[[ var "job_name" . ]]" {
    count = 1

    network {
      mode = "host"
      port "mongo" {
        static = [[ var "port" . ]]
      }
      port "db" {
        static = [[ var "db_port" . ]]
      }
    }

    service {
      name     = "[[ var "job_name" . ]]"
      provider = "nomad"
      port     = "mongo"
    }

    restart {
      attempts = 5
      interval = "10m"
      delay    = "20s"
      mode     = "delay"
    }

    # --- PostgreSQL + DocumentDB extension (prestart sidecar) -------------
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
        POSTGRES_USER     = "[[ var "db_user" . ]]"
        POSTGRES_PASSWORD = "[[ var "db_password" . ]]"
        POSTGRES_DB       = "postgres"
        PGPORT            = "[[ var "db_port" . ]]"
      }

      resources {
        cpu    = [[ (var "postgres_resources" .).cpu ]]
        memory = [[ (var "postgres_resources" .).memory ]]
      }
    }

    # --- FerretDB (main) --------------------------------------------------
    task "ferretdb" {
      driver = "docker"

      config {
        image        = "[[ var "image" . ]]"
        network_mode = "host"
        ports        = ["mongo"]
      }

      env {
        FERRETDB_LISTEN_ADDR   = "0.0.0.0:[[ var "port" . ]]"
        FERRETDB_POSTGRESQL_URL = "postgres://[[ var "db_user" . ]]:[[ var "db_password" . ]]@127.0.0.1:[[ var "db_port" . ]]/postgres"
      }

      resources {
        cpu    = [[ (var "ferretdb_resources" .).cpu ]]
        memory = [[ (var "ferretdb_resources" .).memory ]]
      }
    }
  }
}
