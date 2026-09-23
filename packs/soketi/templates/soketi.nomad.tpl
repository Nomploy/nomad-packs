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
      port "ws" {
        static = [[ var "port" . ]]
      }
      port "metrics" {
        static = [[ var "metrics_port" . ]]
      }
    }

    service {
      name     = "[[ var "job_name" . ]]"
      provider = "nomad"
      port     = "ws"
    }

    restart {
      attempts = 3
      interval = "5m"
      delay    = "15s"
      mode     = "delay"
    }

    task "soketi" {
      driver = "docker"

      config {
        image        = "[[ var "image" . ]]"
        network_mode = "host"
        ports        = ["ws", "metrics"]
      }

      env {
        SOKETI_PORT                 = "[[ var "port" . ]]"
        SOKETI_HOST                 = "0.0.0.0"
        SOKETI_METRICS_ENABLED      = "true"
        SOKETI_METRICS_SERVER_PORT  = "[[ var "metrics_port" . ]]"
        SOKETI_DEFAULT_APP_ID       = "[[ var "app_id" . ]]"
        SOKETI_DEFAULT_APP_KEY      = "[[ var "app_key" . ]]"
        SOKETI_DEFAULT_APP_SECRET   = "[[ var "app_secret" . ]]"
      }

      resources {
        cpu    = [[ (var "resources" .).cpu ]]
        memory = [[ (var "resources" .).memory ]]
      }
    }
  }
}
