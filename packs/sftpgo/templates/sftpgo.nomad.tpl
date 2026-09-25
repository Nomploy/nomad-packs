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
      port "sftp" {
        static = [[ var "sftp_port" . ]]
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

    # chown the volumes so SFTPGo (uid 1000) can write data, keys and its database.
    task "init" {
      driver = "docker"

      lifecycle {
        hook    = "prestart"
        sidecar = false
      }

      config {
        image   = "busybox:latest"
        command = "sh"
        args    = ["-c", "chown -R 1000:1000 /srv/sftpgo /var/lib/sftpgo"]

        mount {
          type   = "volume"
          source = "[[ var "data_volume" . ]]"
          target = "/srv/sftpgo"
        }
        mount {
          type   = "volume"
          source = "[[ var "home_volume" . ]]"
          target = "/var/lib/sftpgo"
        }
      }

      resources {
        cpu    = 50
        memory = 64
      }
    }

    task "sftpgo" {
      driver = "docker"

      config {
        image        = "[[ var "image" . ]]"
        network_mode = "host"
        ports        = ["http", "sftp"]
        mount {
          type   = "volume"
          target = "/srv/sftpgo"
          source = "[[ var "data_volume" . ]]"
        }
        mount {
          type   = "volume"
          target = "/var/lib/sftpgo"
          source = "[[ var "home_volume" . ]]"
        }
      }

      env {
        SFTPGO_HTTPD__BINDINGS__0__PORT = "[[ var "port" . ]]"
        SFTPGO_SFTPD__BINDINGS__0__PORT = "[[ var "sftp_port" . ]]"
      }

      resources {
        cpu    = [[ (var "resources" .).cpu ]]
        memory = [[ (var "resources" .).memory ]]
      }
    }
  }
}
