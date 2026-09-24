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
      port "voice" {
        static = [[ var "voice_port" . ]]
      }
      port "query" {
        static = [[ var "query_port" . ]]
      }
      port "filetransfer" {
        static = [[ var "filetransfer_port" . ]]
      }
    }

    service {
      name     = "[[ var "job_name" . ]]"
      provider = "nomad"
      port     = "voice"
    }

    restart {
      attempts = 3
      interval = "5m"
      delay    = "15s"
      mode     = "delay"
    }

    task "teamspeak" {
      driver = "docker"

      config {
        image        = "[[ var "image" . ]]"
        network_mode = "host"
        ports        = ["voice", "query", "filetransfer"]

        mount {
          type   = "volume"
          source = "[[ var "data_volume" . ]]"
          target = "/var/ts3server"
        }
      }

      env {
        TS3SERVER_LICENSE                = "accept"
        TS3SERVER_QUERY_PORT             = "[[ var "query_port" . ]]"
        TS3SERVER_FILETRANSFER_PORT      = "[[ var "filetransfer_port" . ]]"
        TS3SERVER_DEFAULT_VOICE_PORT     = "[[ var "voice_port" . ]]"
      }

      resources {
        cpu    = [[ (var "resources" .).cpu ]]
        memory = [[ (var "resources" .).memory ]]
      }
    }
  }
}
