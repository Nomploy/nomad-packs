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

    task "healthchecks" {
      driver = "docker"

      config {
        image        = "[[ var "image" . ]]"
        network_mode = "host"
        ports        = ["http"]

        mount {
          type   = "volume"
          source = "[[ var "data_volume" . ]]"
          target = "/data"
        }
      }

      env {
        DEBUG              = "False"
        DB                 = "sqlite"
        DB_NAME            = "/data/hc.sqlite"
        SECRET_KEY         = "[[ var "secret_key" . ]]"
        ALLOWED_HOSTS      = "*"
        SITE_ROOT          = "[[ if ne (var "site_root" .) "" ]][[ var "site_root" . ]][[ else ]]http://localhost:[[ var "port" . ]][[ end ]]"
        SUPERUSER_EMAIL    = "[[ var "superuser_email" . ]]"
        SUPERUSER_PASSWORD = "[[ var "superuser_password" . ]]"
        PORT               = "[[ var "port" . ]]"
      }

      resources {
        cpu    = [[ (var "resources" .).cpu ]]
        memory = [[ (var "resources" .).memory ]]
      }
    }
  }
}
