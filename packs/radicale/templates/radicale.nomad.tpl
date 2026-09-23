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

    task "init" {
      driver = "docker"

      lifecycle {
        hook = "prestart"
      }

      config {
        image   = "busybox:stable"
        command = "sh"
        args    = ["-c", "mkdir -p /var/lib/radicale/collections && chown -R [[ var "uid" . ]]:[[ var "uid" . ]] /var/lib/radicale/collections"]
        mount {
          type   = "volume"
          target = "/var/lib/radicale/collections"
          source = "[[ var "data_volume" . ]]"
        }
      }

      resources {
        cpu    = 50
        memory = 32
      }
    }

    task "radicale" {
      driver = "docker"

      config {
        image        = "[[ var "image" . ]]"
        network_mode = "host"
        ports        = ["http"]
        volumes = [
          "local/config:/etc/radicale/config",
          "local/users:/etc/radicale/users",
        ]
        mount {
          type   = "volume"
          target = "/var/lib/radicale/collections"
          source = "[[ var "data_volume" . ]]"
        }
      }

      template {
        destination = "local/config"
        data        = <<EOH
[server]
hosts = 0.0.0.0:[[ var "port" . ]]

[auth]
type = htpasswd
htpasswd_filename = /etc/radicale/users
htpasswd_encryption = plain

[storage]
filesystem_folder = /var/lib/radicale/collections
EOH
      }

      template {
        destination = "local/users"
        data        = <<EOH
[[ var "username" . ]]:[[ var "password" . ]]
EOH
      }

      resources {
        cpu    = [[ (var "resources" .).cpu ]]
        memory = [[ (var "resources" .).memory ]]
      }
    }
  }
}
