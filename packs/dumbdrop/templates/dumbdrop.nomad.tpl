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

    # chown the uploads volume so DumbDrop (uid 1000) can write files.
    task "init" {
      driver = "docker"

      lifecycle {
        hook    = "prestart"
        sidecar = false
      }

      config {
        image   = "busybox:latest"
        command = "sh"
        args    = ["-c", "chown -R 1000:1000 /app/uploads"]

        mount {
          type   = "volume"
          source = "[[ var "data_volume" . ]]"
          target = "/app/uploads"
        }
      }

      resources {
        cpu    = 50
        memory = 64
      }
    }

    task "dumbdrop" {
      driver = "docker"

      config {
        image        = "[[ var "image" . ]]"
        network_mode = "host"
        ports        = ["http"]
        mount {
          type   = "volume"
          target = "/app/uploads"
          source = "[[ var "data_volume" . ]]"
        }
      }

      env {
        PORT          = "[[ var "port" . ]]"
        UPLOAD_DIR    = "/app/uploads"
        MAX_FILE_SIZE = "[[ var "max_file_size" . ]]"
        BASE_URL      = "[[ if ne (var "base_url" .) "" ]][[ var "base_url" . ]][[ else ]]http://localhost:[[ var "port" . ]]/[[ end ]]"
        [[- if ne (var "pin" .) "" ]]
        DUMBDROP_PIN = "[[ var "pin" . ]]"
        [[- end ]]
      }

      resources {
        cpu    = [[ (var "resources" .).cpu ]]
        memory = [[ (var "resources" .).memory ]]
      }
    }
  }
}
