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

    # chown the data volume so Vikunja (uid 1000) can write the SQLite DB + files.
    task "init" {
      driver = "docker"

      lifecycle {
        hook    = "prestart"
        sidecar = false
      }

      config {
        image   = "busybox:latest"
        command = "sh"
        args    = ["-c", "mkdir -p /db/files && chown -R 1000:1000 /db"]

        mount {
          type   = "volume"
          source = "[[ var "data_volume" . ]]"
          target = "/db"
        }
      }

      resources {
        cpu    = 50
        memory = 64
      }
    }

    task "vikunja" {
      driver = "docker"

      config {
        image        = "[[ var "image" . ]]"
        network_mode = "host"
        ports        = ["http"]

        mount {
          type   = "volume"
          source = "[[ var "data_volume" . ]]"
          target = "/db"
        }
      }

      env {
        VIKUNJA_SERVICE_INTERFACE = "0.0.0.0:[[ var "port" . ]]"
        VIKUNJA_DATABASE_TYPE     = "sqlite"
        VIKUNJA_DATABASE_PATH     = "/db/vikunja.db"
        VIKUNJA_FILES_BASEPATH    = "/db/files"
        [[- if ne (var "public_url" .) "" ]]
        VIKUNJA_SERVICE_PUBLICURL = "[[ var "public_url" . ]]"
        [[- end ]]
        [[- if ne (var "service_secret" .) "" ]]
        VIKUNJA_SERVICE_JWTSECRET = "[[ var "service_secret" . ]]"
        [[- end ]]
      }

      resources {
        cpu    = [[ (var "resources" .).cpu ]]
        memory = [[ (var "resources" .).memory ]]
      }
    }
  }
}
