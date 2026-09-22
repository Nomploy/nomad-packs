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

    task "init" {
      driver = "docker"

      lifecycle {
        hook = "prestart"
      }

      config {
        image   = "busybox:stable"
        command = "sh"
        args    = ["-c", "mkdir -p /hedgedoc/public/uploads && chown -R [[ var "uid" . ]]:[[ var "uid" . ]] /hedgedoc/public/uploads"]
        mount {
          type   = "volume"
          target = "/hedgedoc/public/uploads"
          source = "[[ var "uploads_volume" . ]]"
        }
      }

      resources {
        cpu    = 50
        memory = 32
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
        POSTGRES_DB       = "hedgedoc"
        POSTGRES_USER     = "hedgedoc"
        POSTGRES_PASSWORD = "[[ var "db_password" . ]]"
        PGPORT            = "[[ var "db_port" . ]]"
      }

      resources {
        cpu    = [[ (var "postgres_resources" .).cpu ]]
        memory = [[ (var "postgres_resources" .).memory ]]
      }
    }

    task "hedgedoc" {
      driver = "docker"

      config {
        image        = "[[ var "image" . ]]"
        network_mode = "host"
        ports        = ["http"]
        mount {
          type   = "volume"
          target = "/hedgedoc/public/uploads"
          source = "[[ var "uploads_volume" . ]]"
        }
      }

      env {
        CMD_DB_URL          = "postgres://hedgedoc:[[ var "db_password" . ]]@127.0.0.1:[[ var "db_port" . ]]/hedgedoc"
        CMD_PORT            = "[[ var "port" . ]]"
        CMD_URL_ADDPORT     = "true"
        CMD_PROTOCOL_USESSL = "false"
        CMD_ALLOW_ANONYMOUS = "[[ var "allow_anonymous" . ]]"
        [[- if ne (var "domain" .) "" ]]
        CMD_DOMAIN = "[[ var "domain" . ]]"
        [[- end ]]
      }

      resources {
        cpu    = [[ (var "resources" .).cpu ]]
        memory = [[ (var "resources" .).memory ]]
      }
    }
  }
}
