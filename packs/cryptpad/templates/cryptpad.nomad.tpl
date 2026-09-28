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
      port "sandbox" {
        static = [[ var "sandbox_port" . ]]
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

    task "cryptpad" {
      driver = "docker"

      config {
        image        = "[[ var "image" . ]]"
        network_mode = "host"
        ports        = ["http", "sandbox"]

        mount {
          type   = "volume"
          source = "[[ var "data_volume" . ]]"
          target = "/cryptpad/data"
        }
        mount {
          type   = "volume"
          source = "[[ var "blob_volume" . ]]"
          target = "/cryptpad/blob"
        }
        mount {
          type   = "volume"
          source = "[[ var "block_volume" . ]]"
          target = "/cryptpad/block"
        }
        mount {
          type   = "volume"
          source = "[[ var "datastore_volume" . ]]"
          target = "/cryptpad/datastore"
        }
        mount {
          type   = "volume"
          source = "[[ var "customize_volume" . ]]"
          target = "/cryptpad/customize"
        }
      }

      env {
        CPAD_MAIN_DOMAIN    = "[[ var "main_domain" . ]]"
        CPAD_SANDBOX_DOMAIN = "[[ var "sandbox_domain" . ]]"
        CPAD_HTTP2_DISABLE  = "true"
      }

      resources {
        cpu    = [[ (var "resources" .).cpu ]]
        memory = [[ (var "resources" .).memory ]]
      }
    }
  }
}
