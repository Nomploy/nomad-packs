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
        POSTGRES_DB       = "zitadel"
        POSTGRES_USER     = "zitadel"
        POSTGRES_PASSWORD = "[[ var "db_password" . ]]"
        PGPORT            = "[[ var "db_port" . ]]"
      }

      resources {
        cpu    = [[ (var "db_resources" .).cpu ]]
        memory = [[ (var "db_resources" .).memory ]]
      }
    }

    task "zitadel" {
      driver = "docker"

      config {
        image        = "[[ var "image" . ]]"
        network_mode = "host"
        ports        = ["http"]
        args         = ["start-from-init", "--tlsMode", "disabled"]
      }

      env {
        ZITADEL_MASTERKEY                            = "[[ var "masterkey" . ]]"
        ZITADEL_EXTERNALDOMAIN                       = "[[ var "external_domain" . ]]"
        ZITADEL_EXTERNALPORT                         = "[[ var "port" . ]]"
        ZITADEL_EXTERNALSECURE                       = "[[ var "external_secure" . ]]"
        ZITADEL_TLS_ENABLED                          = "false"
        ZITADEL_PORT                                 = "[[ var "port" . ]]"
        ZITADEL_DATABASE_POSTGRES_HOST               = "127.0.0.1"
        ZITADEL_DATABASE_POSTGRES_PORT               = "[[ var "db_port" . ]]"
        ZITADEL_DATABASE_POSTGRES_DATABASE           = "zitadel"
        ZITADEL_DATABASE_POSTGRES_USER_USERNAME      = "zitadel"
        ZITADEL_DATABASE_POSTGRES_USER_PASSWORD      = "[[ var "db_password" . ]]"
        ZITADEL_DATABASE_POSTGRES_USER_SSL_MODE      = "disable"
        ZITADEL_DATABASE_POSTGRES_ADMIN_USERNAME     = "zitadel"
        ZITADEL_DATABASE_POSTGRES_ADMIN_PASSWORD     = "[[ var "db_password" . ]]"
        ZITADEL_DATABASE_POSTGRES_ADMIN_SSL_MODE     = "disable"
        ZITADEL_FIRSTINSTANCE_ORG_HUMAN_USERNAME     = "[[ var "admin_username" . ]]"
        ZITADEL_FIRSTINSTANCE_ORG_HUMAN_PASSWORD     = "[[ var "admin_password" . ]]"
        ZITADEL_FIRSTINSTANCE_ORG_HUMAN_PASSWORDCHANGEREQUIRED = "false"
      }

      resources {
        cpu    = [[ (var "resources" .).cpu ]]
        memory = [[ (var "resources" .).memory ]]
      }
    }
  }
}
