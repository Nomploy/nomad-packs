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
      port "mqtt" {
        static = [[ var "mqtt_port" . ]]
      }
      port "ws" {
        static = [[ var "ws_port" . ]]
      }
      port "dashboard" {
        static = [[ var "dashboard_port" . ]]
      }
    }

    service {
      name     = "[[ var "job_name" . ]]"
      provider = "nomad"
      port     = "dashboard"
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
        args    = ["-c", "mkdir -p /opt/emqx/data && chown -R [[ var "uid" . ]]:[[ var "uid" . ]] /opt/emqx/data"]
        mount {
          type   = "volume"
          target = "/opt/emqx/data"
          source = "[[ var "data_volume" . ]]"
        }
      }

      resources {
        cpu    = 50
        memory = 32
      }
    }

    task "emqx" {
      driver = "docker"

      config {
        image        = "[[ var "image" . ]]"
        network_mode = "host"
        ports        = ["mqtt", "ws", "dashboard"]
        mount {
          type   = "volume"
          target = "/opt/emqx/data"
          source = "[[ var "data_volume" . ]]"
        }
      }

      env {
        EMQX_NODE__NAME                            = "emqx@127.0.0.1"
        EMQX_DASHBOARD__DEFAULT_PASSWORD           = "[[ var "dashboard_password" . ]]"
        EMQX_DASHBOARD__LISTENERS__HTTP__BIND      = "0.0.0.0:[[ var "dashboard_port" . ]]"
        EMQX_LISTENERS__TCP__DEFAULT__BIND         = "0.0.0.0:[[ var "mqtt_port" . ]]"
        EMQX_LISTENERS__WS__DEFAULT__BIND          = "0.0.0.0:[[ var "ws_port" . ]]"
      }

      resources {
        cpu    = [[ (var "resources" .).cpu ]]
        memory = [[ (var "resources" .).memory ]]
      }
    }
  }
}
