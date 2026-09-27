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
      port "redis" {
        static = [[ var "redis_port" . ]]
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

    task "redis" {
      driver = "docker"

      lifecycle {
        hook    = "prestart"
        sidecar = true
      }

      config {
        image        = "[[ var "redis_image" . ]]"
        network_mode = "host"
        ports        = ["redis"]
        args         = ["redis-server", "--port", "[[ var "redis_port" . ]]"]

        mount {
          type   = "volume"
          source = "[[ var "redis_data_volume" . ]]"
          target = "/data"
        }
      }

      resources {
        cpu    = [[ (var "redis_resources" .).cpu ]]
        memory = [[ (var "redis_resources" .).memory ]]
      }
    }

    task "kener" {
      driver = "docker"

      config {
        image        = "[[ var "image" . ]]"
        network_mode = "host"
        ports        = ["http"]

        mount {
          type   = "volume"
          source = "[[ var "data_volume" . ]]"
          target = "/app/database"
        }
      }

      env {
        PORT             = "[[ var "port" . ]]"
        ORIGIN           = "[[ var "origin" . ]]"
        KENER_SECRET_KEY = "[[ var "secret_key" . ]]"
        REDIS_URL        = "redis://127.0.0.1:[[ var "redis_port" . ]]"
      }

      resources {
        cpu    = [[ (var "resources" .).cpu ]]
        memory = [[ (var "resources" .).memory ]]
      }
    }
  }
}
