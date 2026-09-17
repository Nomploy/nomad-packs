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
    count = [[ var "count" . ]]

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

    task "grafana" {
      driver = "docker"

      config {
        image        = "[[ var "image" . ]]"
        network_mode = "host"
        ports        = ["http"]

        # Persistent named volume: a fresh one is initialized from the image's
        # /var/lib/grafana (owned by uid 472), so Grafana can write it.
        mount {
          type   = "volume"
          source = "[[ var "data_volume" . ]]"
          target = "/var/lib/grafana"
        }
      }

      env {
        GF_SERVER_HTTP_PORT         = "[[ var "port" . ]]"
        GF_SECURITY_ADMIN_USER      = "[[ var "admin_user" . ]]"
        GF_SECURITY_ADMIN_PASSWORD  = "[[ var "admin_password" . ]]"
        [[- if ne (var "root_url" .) "" ]]
        GF_SERVER_ROOT_URL          = "[[ var "root_url" . ]]"
        [[- end ]]
      }

      resources {
        cpu    = [[ (var "resources" .).cpu ]]
        memory = [[ (var "resources" .).memory ]]
      }
    }
  }
}
