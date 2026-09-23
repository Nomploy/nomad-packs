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

    task "microbin" {
      driver = "docker"

      config {
        image        = "[[ var "image" . ]]"
        network_mode = "host"
        ports        = ["http"]
        mount {
          type   = "volume"
          target = "/app/microbin_data"
          source = "[[ var "data_volume" . ]]"
        }
      }

      env {
        MICROBIN_PORT           = "[[ var "port" . ]]"
        MICROBIN_BIND           = "0.0.0.0"
        MICROBIN_ADMIN_USERNAME = "[[ var "admin_username" . ]]"
        MICROBIN_ADMIN_PASSWORD = "[[ var "admin_password" . ]]"
        MICROBIN_PUBLIC_PATH    = "[[ if ne (var "public_url" .) "" ]][[ var "public_url" . ]][[ else ]]http://localhost:[[ var "port" . ]][[ end ]]"
      }

      resources {
        cpu    = [[ (var "resources" .).cpu ]]
        memory = [[ (var "resources" .).memory ]]
      }
    }
  }
}
