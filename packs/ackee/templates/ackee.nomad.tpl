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
      port "mongo" {
        static = [[ var "mongo_port" . ]]
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

    task "mongodb" {
      driver = "docker"

      lifecycle {
        hook    = "prestart"
        sidecar = true
      }

      config {
        image        = "[[ var "mongo_image" . ]]"
        network_mode = "host"
        args         = ["--port", "[[ var "mongo_port" . ]]"]

        mount {
          type   = "volume"
          source = "[[ var "mongo_data_volume" . ]]"
          target = "/data/db"
        }
      }

      resources {
        cpu    = [[ (var "mongo_resources" .).cpu ]]
        memory = [[ (var "mongo_resources" .).memory ]]
      }
    }

    task "ackee" {
      driver = "docker"

      config {
        image        = "[[ var "image" . ]]"
        network_mode = "host"
        ports        = ["http"]
      }

      env {
        PORT           = "[[ var "port" . ]]"
        ACKEE_MONGODB  = "mongodb://127.0.0.1:[[ var "mongo_port" . ]]/ackee"
        ACKEE_USERNAME = "[[ var "admin_username" . ]]"
        ACKEE_PASSWORD = "[[ var "admin_password" . ]]"
      }

      resources {
        cpu    = [[ (var "resources" .).cpu ]]
        memory = [[ (var "resources" .).memory ]]
      }
    }
  }
}
