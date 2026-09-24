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
        static = [[ var "http_port" . ]]
      }
      port "ssh" {
        static = [[ var "ssh_port" . ]]
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

    task "forgejo" {
      driver = "docker"

      config {
        image        = "[[ var "image" . ]]"
        network_mode = "host"
        ports        = ["http", "ssh"]

        # Forgejo's entrypoint chowns /data on start, so a fresh named volume is fine.
        mount {
          type   = "volume"
          source = "[[ var "data_volume" . ]]"
          target = "/data"
        }
      }

      env {
        USER_UID = "1000"
        USER_GID = "1000"

        FORGEJO__server__HTTP_PORT       = "[[ var "http_port" . ]]"
        FORGEJO__server__SSH_PORT        = "[[ var "ssh_port" . ]]"
        FORGEJO__server__SSH_LISTEN_PORT = "[[ var "ssh_port" . ]]"
        [[- if ne (var "root_url" .) "" ]]
        FORGEJO__server__ROOT_URL        = "[[ var "root_url" . ]]"
        [[- end ]]
      }

      resources {
        cpu    = [[ (var "resources" .).cpu ]]
        memory = [[ (var "resources" .).memory ]]
      }
    }
  }
}
