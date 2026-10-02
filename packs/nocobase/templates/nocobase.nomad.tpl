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
        POSTGRES_DB       = "nocobase"
        POSTGRES_USER     = "nocobase"
        POSTGRES_PASSWORD = "[[ var "db_password" . ]]"
        PGPORT            = "[[ var "db_port" . ]]"
      }

      resources {
        cpu    = [[ (var "db_resources" .).cpu ]]
        memory = [[ (var "db_resources" .).memory ]]
      }
    }

    task "nocobase" {
      driver = "docker"

      config {
        image        = "[[ var "image" . ]]"
        network_mode = "host"
        ports        = ["http"]

        mount {
          type   = "volume"
          source = "[[ var "storage_volume" . ]]"
          target = "/app/nocobase/storage"
        }
      }

      env {
        APP_PORT      = "[[ var "port" . ]]"
        APP_KEY       = "[[ var "app_key" . ]]"
        DB_DIALECT    = "postgres"
        DB_HOST       = "127.0.0.1"
        DB_PORT       = "[[ var "db_port" . ]]"
        DB_DATABASE   = "nocobase"
        DB_USER       = "nocobase"
        DB_PASSWORD   = "[[ var "db_password" . ]]"
        DB_UNDERSCORED = "true"
      }

      resources {
        cpu    = [[ (var "resources" .).cpu ]]
        memory = [[ (var "resources" .).memory ]]
      }
    }
  }
}
