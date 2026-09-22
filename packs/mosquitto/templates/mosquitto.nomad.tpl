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
      port "mqtt" {
        static = [[ var "port" . ]]
      }
    }

    service {
      name     = "[[ var "job_name" . ]]"
      provider = "nomad"
      port     = "mqtt"
    }

    restart {
      attempts = 3
      interval = "5m"
      delay    = "15s"
      mode     = "delay"
    }

    # chown the data volume so mosquitto (uid 1883) can persist messages.
    task "init" {
      driver = "docker"

      lifecycle {
        hook    = "prestart"
        sidecar = false
      }

      config {
        image   = "busybox:latest"
        command = "sh"
        args    = ["-c", "chown -R 1883:1883 /mosquitto/data"]

        mount {
          type   = "volume"
          source = "[[ var "data_volume" . ]]"
          target = "/mosquitto/data"
        }
      }

      resources {
        cpu    = 50
        memory = 64
      }
    }

    task "mosquitto" {
      driver = "docker"

      config {
        image        = "[[ var "image" . ]]"
        network_mode = "host"
        ports        = ["mqtt"]
        volumes      = ["local/mosquitto.conf:/mosquitto/config/mosquitto.conf"]

        mount {
          type   = "volume"
          source = "[[ var "data_volume" . ]]"
          target = "/mosquitto/data"
        }
      }

      template {
        destination = "local/mosquitto.conf"
        data        = <<EOH
listener [[ var "port" . ]] 0.0.0.0
allow_anonymous [[ var "allow_anonymous" . ]]
persistence true
persistence_location /mosquitto/data/
EOH
      }

      resources {
        cpu    = [[ (var "resources" .).cpu ]]
        memory = [[ (var "resources" .).memory ]]
      }
    }
  }
}
