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

    task "photoprism" {
      driver = "docker"

      config {
        image        = "[[ var "image" . ]]"
        network_mode = "host"
        ports        = ["http"]
        mount {
          type   = "volume"
          target = "/photoprism/storage"
          source = "[[ var "storage_volume" . ]]"
        }
        mount {
          type   = "volume"
          target = "/photoprism/originals"
          source = "[[ var "originals_volume" . ]]"
        }
      }

      env {
        PHOTOPRISM_HTTP_HOST      = "0.0.0.0"
        PHOTOPRISM_HTTP_PORT      = "[[ var "port" . ]]"
        PHOTOPRISM_ADMIN_USER     = "[[ var "admin_user" . ]]"
        PHOTOPRISM_ADMIN_PASSWORD = "[[ var "admin_password" . ]]"
        PHOTOPRISM_DATABASE_DRIVER = "sqlite"
        [[- if ne (var "site_url" .) "" ]]
        PHOTOPRISM_SITE_URL = "[[ var "site_url" . ]]"
        [[- end ]]
      }

      resources {
        cpu    = [[ (var "resources" .).cpu ]]
        memory = [[ (var "resources" .).memory ]]
      }
    }
  }
}
