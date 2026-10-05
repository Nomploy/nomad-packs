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

    task "isso" {
      driver = "docker"

      config {
        image        = "[[ var "image" . ]]"
        network_mode = "host"
        ports        = ["http"]
        volumes      = ["local/isso.cfg:/config/isso.cfg"]

        mount {
          type   = "volume"
          source = "[[ var "data_volume" . ]]"
          target = "/db"
        }
      }

      env {
        ISSO_SETTINGS = "/config/isso.cfg"
      }

      template {
        destination = "local/isso.cfg"
        data        = <<EOH
[general]
dbpath = /db/comments.db
host = [[ var "host" . ]]

[server]
listen = http://0.0.0.0:[[ var "port" . ]]

[guard]
enabled = true
ratelimit = 2
EOH
      }

      resources {
        cpu    = [[ (var "resources" .).cpu ]]
        memory = [[ (var "resources" .).memory ]]
      }
    }
  }
}
