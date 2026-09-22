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

    task "influxdb" {
      driver = "docker"

      config {
        image        = "[[ var "image" . ]]"
        network_mode = "host"
        ports        = ["http"]

        mount {
          type   = "volume"
          source = "[[ var "data_volume" . ]]"
          target = "/var/lib/influxdb2"
        }
      }

      env {
        INFLUXD_HTTP_BIND_ADDRESS         = ":[[ var "port" . ]]"
        DOCKER_INFLUXDB_INIT_MODE         = "setup"
        DOCKER_INFLUXDB_INIT_USERNAME     = "[[ var "admin_user" . ]]"
        DOCKER_INFLUXDB_INIT_PASSWORD     = "[[ var "admin_password" . ]]"
        DOCKER_INFLUXDB_INIT_ORG          = "[[ var "org" . ]]"
        DOCKER_INFLUXDB_INIT_BUCKET       = "[[ var "bucket" . ]]"
        DOCKER_INFLUXDB_INIT_ADMIN_TOKEN  = "[[ var "admin_token" . ]]"
      }

      resources {
        cpu    = [[ (var "resources" .).cpu ]]
        memory = [[ (var "resources" .).memory ]]
      }
    }
  }
}
