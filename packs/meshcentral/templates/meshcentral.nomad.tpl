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
      port "https" {
        static = [[ var "port" . ]]
      }
      port "redir" {
        static = [[ var "redir_port" . ]]
      }
    }

    service {
      name     = "[[ var "job_name" . ]]"
      provider = "nomad"
      port     = "https"
    }

    restart {
      attempts = 3
      interval = "5m"
      delay    = "15s"
      mode     = "delay"
    }

    task "meshcentral" {
      driver = "docker"

      config {
        image        = "[[ var "image" . ]]"
        network_mode = "host"
        ports        = ["https", "redir"]

        mount {
          type   = "volume"
          source = "[[ var "data_volume" . ]]"
          target = "/opt/meshcentral/meshcentral-data"
        }
        mount {
          type   = "volume"
          source = "[[ var "files_volume" . ]]"
          target = "/opt/meshcentral/meshcentral-files"
        }
      }

      env {
        HOSTNAME           = "[[ var "hostname" . ]]"
        PORT               = "[[ var "port" . ]]"
        REDIR_PORT         = "[[ var "redir_port" . ]]"
        USE_MONGODB        = "false"
        ALLOW_NEW_ACCOUNTS = "[[ var "allow_new_accounts" . ]]"
      }

      resources {
        cpu    = [[ (var "resources" .).cpu ]]
        memory = [[ (var "resources" .).memory ]]
      }
    }
  }
}
