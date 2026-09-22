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

    task "flowise" {
      driver = "docker"

      config {
        image        = "[[ var "image" . ]]"
        network_mode = "host"
        ports        = ["http"]
        mount {
          type   = "volume"
          target = "/root/.flowise"
          source = "[[ var "data_volume" . ]]"
        }
      }

      env {
        PORT           = "[[ var "port" . ]]"
        DATABASE_PATH  = "/root/.flowise"
        APIKEY_PATH    = "/root/.flowise"
        SECRETKEY_PATH = "/root/.flowise"
        LOG_PATH       = "/root/.flowise/logs"
        BLOB_STORAGE_PATH = "/root/.flowise/storage"
        [[- if ne (var "username" .) "" ]]
        FLOWISE_USERNAME = "[[ var "username" . ]]"
        FLOWISE_PASSWORD = "[[ var "password" . ]]"
        [[- end ]]
      }

      resources {
        cpu    = [[ (var "resources" .).cpu ]]
        memory = [[ (var "resources" .).memory ]]
      }
    }
  }
}
