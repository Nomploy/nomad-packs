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
      port "graphql" {
        static = [[ var "graphql_port" . ]]
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

    task "init-perms" {
      driver = "docker"

      lifecycle {
        hook    = "prestart"
        sidecar = false
      }

      config {
        image   = "busybox:1.36"
        command = "sh"
        args    = ["-c", "mkdir -p /data/config /data/db && chmod -R 0777 /data"]

        mount {
          type   = "volume"
          source = "[[ var "data_volume" . ]]"
          target = "/data"
        }
      }

      resources {
        cpu    = 100
        memory = 64
      }
    }

    task "netalertx" {
      driver = "docker"

      config {
        image        = "[[ var "image" . ]]"
        network_mode = "host"
        ports        = ["http", "graphql"]
        cap_add      = ["net_raw", "net_admin", "net_bind_service"]

        mount {
          type   = "volume"
          source = "[[ var "data_volume" . ]]"
          target = "/data"
        }
      }

      env {
        PORT              = "[[ var "port" . ]]"
        APP_CONF_OVERRIDE = "{\"GRAPHQL_PORT\":\"[[ var "graphql_port" . ]]\"}"
      }

      resources {
        cpu    = [[ (var "resources" .).cpu ]]
        memory = [[ (var "resources" .).memory ]]
      }
    }
  }
}
