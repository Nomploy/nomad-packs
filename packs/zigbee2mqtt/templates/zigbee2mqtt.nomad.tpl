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

    task "zigbee2mqtt" {
      driver = "docker"

      config {
        image        = "[[ var "image" . ]]"
        network_mode = "host"
        ports        = ["http"]

        devices = [
          {
            host_path      = "[[ var "serial_device" . ]]"
            container_path = "[[ var "serial_device" . ]]"
          },
        ]

        mount {
          type   = "volume"
          source = "[[ var "data_volume" . ]]"
          target = "/app/data"
        }
      }

      env {
        ZIGBEE2MQTT_CONFIG_MQTT_SERVER      = "[[ var "mqtt_server" . ]]"
        ZIGBEE2MQTT_CONFIG_SERIAL_PORT      = "[[ var "serial_device" . ]]"
        ZIGBEE2MQTT_CONFIG_FRONTEND_ENABLED = "true"
        ZIGBEE2MQTT_CONFIG_FRONTEND_PORT    = "[[ var "port" . ]]"
        ZIGBEE2MQTT_CONFIG_PERMIT_JOIN      = "false"
      }

      resources {
        cpu    = [[ (var "resources" .).cpu ]]
        memory = [[ (var "resources" .).memory ]]
      }
    }
  }
}
