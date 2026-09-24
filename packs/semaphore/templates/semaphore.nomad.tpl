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

    task "semaphore" {
      driver = "docker"

      config {
        image        = "[[ var "image" . ]]"
        network_mode = "host"
        ports        = ["http"]

        mount {
          type   = "volume"
          source = "[[ var "data_volume" . ]]"
          target = "/var/lib/semaphore"
        }
        mount {
          type   = "volume"
          source = "[[ var "config_volume" . ]]"
          target = "/etc/semaphore"
        }
      }

      env {
        SEMAPHORE_DB_DIALECT            = "bolt"
        SEMAPHORE_ADMIN                 = "[[ var "admin_user" . ]]"
        SEMAPHORE_ADMIN_PASSWORD        = "[[ var "admin_password" . ]]"
        SEMAPHORE_ADMIN_NAME            = "[[ var "admin_name" . ]]"
        SEMAPHORE_ADMIN_EMAIL           = "[[ var "admin_email" . ]]"
        SEMAPHORE_ACCESS_KEY_ENCRYPTION = "[[ var "access_key_encryption" . ]]"
        SEMAPHORE_PLAYBOOK_PATH         = "/tmp/semaphore"
      }

      resources {
        cpu    = [[ (var "resources" .).cpu ]]
        memory = [[ (var "resources" .).memory ]]
      }
    }
  }
}
