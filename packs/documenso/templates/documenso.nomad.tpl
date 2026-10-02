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

    task "cert-init" {
      driver = "docker"

      lifecycle {
        hook    = "prestart"
        sidecar = false
      }

      config {
        image      = "[[ var "openssl_image" . ]]"
        entrypoint = ["/bin/sh", "-c"]
        args = [
          "if [ ! -f /opt/documenso/cert.p12 ]; then openssl req -x509 -newkey rsa:2048 -keyout /opt/documenso/key.pem -out /opt/documenso/crt.pem -days 3650 -nodes -subj '/CN=Documenso' && openssl pkcs12 -export -out /opt/documenso/cert.p12 -inkey /opt/documenso/key.pem -in /opt/documenso/crt.pem -passout pass: && echo 'generated signing certificate'; else echo 'signing certificate already present'; fi",
        ]

        mount {
          type   = "volume"
          source = "[[ var "cert_volume" . ]]"
          target = "/opt/documenso"
        }
      }

      resources {
        cpu    = 100
        memory = 64
      }
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
        POSTGRES_DB       = "documenso"
        POSTGRES_USER     = "documenso"
        POSTGRES_PASSWORD = "[[ var "db_password" . ]]"
        PGPORT            = "[[ var "db_port" . ]]"
      }

      resources {
        cpu    = [[ (var "db_resources" .).cpu ]]
        memory = [[ (var "db_resources" .).memory ]]
      }
    }

    task "documenso" {
      driver = "docker"

      config {
        image        = "[[ var "image" . ]]"
        network_mode = "host"
        ports        = ["http"]

        mount {
          type     = "volume"
          source   = "[[ var "cert_volume" . ]]"
          target   = "/opt/documenso"
          readonly = true
        }
      }

      env {
        PORT                                  = "[[ var "port" . ]]"
        NEXTAUTH_SECRET                       = "[[ var "nextauth_secret" . ]]"
        NEXT_PRIVATE_ENCRYPTION_KEY           = "[[ var "encryption_key" . ]]"
        NEXT_PRIVATE_ENCRYPTION_SECONDARY_KEY = "[[ var "encryption_secondary_key" . ]]"
        NEXT_PUBLIC_WEBAPP_URL                = "[[ var "webapp_url" . ]]"
        NEXT_PRIVATE_INTERNAL_WEBAPP_URL      = "http://127.0.0.1:[[ var "port" . ]]"
        NEXT_PRIVATE_DATABASE_URL             = "postgres://documenso:[[ var "db_password" . ]]@127.0.0.1:[[ var "db_port" . ]]/documenso"
        NEXT_PRIVATE_DIRECT_DATABASE_URL      = "postgres://documenso:[[ var "db_password" . ]]@127.0.0.1:[[ var "db_port" . ]]/documenso"
        NEXT_PUBLIC_UPLOAD_TRANSPORT          = "database"
        NEXT_PRIVATE_SMTP_TRANSPORT           = "[[ var "smtp_transport" . ]]"
        NEXT_PRIVATE_SMTP_HOST                = "[[ var "smtp_host" . ]]"
        NEXT_PRIVATE_SMTP_PORT                = "[[ var "smtp_port" . ]]"
        NEXT_PRIVATE_SMTP_USERNAME            = "[[ var "smtp_username" . ]]"
        NEXT_PRIVATE_SMTP_PASSWORD            = "[[ var "smtp_password" . ]]"
        NEXT_PRIVATE_SMTP_FROM_NAME           = "[[ var "smtp_from_name" . ]]"
        NEXT_PRIVATE_SMTP_FROM_ADDRESS        = "[[ var "smtp_from_address" . ]]"
        NEXT_PRIVATE_SIGNING_LOCAL_FILE_PATH  = "/opt/documenso/cert.p12"
        NEXT_PRIVATE_SIGNING_PASSPHRASE       = ""
      }

      resources {
        cpu    = [[ (var "resources" .).cpu ]]
        memory = [[ (var "resources" .).memory ]]
      }
    }
  }
}
