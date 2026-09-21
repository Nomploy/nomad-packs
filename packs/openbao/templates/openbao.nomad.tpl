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

    # chown the storage volume so OpenBao (uid 100) can write it.
    task "init" {
      driver = "docker"

      lifecycle {
        hook    = "prestart"
        sidecar = false
      }

      config {
        image   = "busybox:latest"
        command = "sh"
        args    = ["-c", "chown -R 100:1000 /openbao/file"]

        mount {
          type   = "volume"
          source = "[[ var "data_volume" . ]]"
          target = "/openbao/file"
        }
      }

      resources {
        cpu    = 50
        memory = 64
      }
    }

    task "openbao" {
      driver = "docker"

      config {
        image        = "[[ var "image" . ]]"
        network_mode = "host"
        args         = ["server", "-config=/local/openbao.hcl"]

        mount {
          type   = "volume"
          source = "[[ var "data_volume" . ]]"
          target = "/openbao/file"
        }
      }

      # File storage, HTTP listener, mlock disabled (so no IPC_LOCK capability needed).
      template {
        destination = "local/openbao.hcl"
        data        = <<EOH
storage "file" {
  path = "/openbao/file"
}

listener "tcp" {
  address     = "0.0.0.0:[[ var "port" . ]]"
  tls_disable = true
}

disable_mlock = true
ui            = true
api_addr      = "http://127.0.0.1:[[ var "port" . ]]"
EOH
      }

      resources {
        cpu    = [[ (var "resources" .).cpu ]]
        memory = [[ (var "resources" .).memory ]]
      }
    }
  }
}
