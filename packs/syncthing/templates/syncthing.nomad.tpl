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
      port "gui" {
        static = [[ var "gui_port" . ]]
      }
      port "sync" {
        static = [[ var "sync_port" . ]]
      }
    }

    service {
      name     = "[[ var "job_name" . ]]"
      provider = "nomad"
      port     = "gui"
    }

    restart {
      attempts = 3
      interval = "5m"
      delay    = "15s"
      mode     = "delay"
    }

    task "init" {
      driver = "docker"

      lifecycle {
        hook = "prestart"
      }

      config {
        image   = "busybox:stable"
        command = "sh"
        args    = ["-c", "mkdir -p /var/syncthing && chown -R [[ var "uid" . ]]:[[ var "gid" . ]] /var/syncthing"]
        mount {
          type   = "volume"
          target = "/var/syncthing"
          source = "[[ var "data_volume" . ]]"
        }
      }

      resources {
        cpu    = 50
        memory = 32
      }
    }

    task "syncthing" {
      driver = "docker"

      config {
        image        = "[[ var "image" . ]]"
        network_mode = "host"
        ports        = ["gui", "sync"]
        mount {
          type   = "volume"
          target = "/var/syncthing"
          source = "[[ var "data_volume" . ]]"
        }
      }

      env {
        PUID        = "[[ var "uid" . ]]"
        PGID        = "[[ var "gid" . ]]"
        STGUIADDRESS = "0.0.0.0:[[ var "gui_port" . ]]"
      }

      resources {
        cpu    = [[ (var "resources" .).cpu ]]
        memory = [[ (var "resources" .).memory ]]
      }
    }
  }
}
