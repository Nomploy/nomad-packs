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
      port "ssh" {
        static = [[ var "port" . ]]
      }
      port "http" {
        static = [[ var "http_port" . ]]
      }
      port "git" {
        static = [[ var "git_port" . ]]
      }
      port "stats" {
        static = [[ var "stats_port" . ]]
      }
    }

    service {
      name     = "[[ var "job_name" . ]]"
      provider = "nomad"
      port     = "ssh"
    }

    restart {
      attempts = 3
      interval = "5m"
      delay    = "15s"
      mode     = "delay"
    }

    task "soft-serve" {
      driver = "docker"

      config {
        image        = "[[ var "image" . ]]"
        network_mode = "host"
        ports        = ["ssh", "http", "git", "stats"]
        mount {
          type   = "volume"
          target = "/soft-serve"
          source = "[[ var "data_volume" . ]]"
        }
      }

      env {
        SOFT_SERVE_DATA_PATH          = "/soft-serve"
        SOFT_SERVE_SSH_LISTEN_ADDR    = ":[[ var "port" . ]]"
        SOFT_SERVE_HTTP_LISTEN_ADDR   = ":[[ var "http_port" . ]]"
        SOFT_SERVE_GIT_LISTEN_ADDR    = ":[[ var "git_port" . ]]"
        SOFT_SERVE_STATS_LISTEN_ADDR  = ":[[ var "stats_port" . ]]"
        SOFT_SERVE_INITIAL_ADMIN_KEYS = "[[ var "admin_keys" . ]]"
      }

      resources {
        cpu    = [[ (var "resources" .).cpu ]]
        memory = [[ (var "resources" .).memory ]]
      }
    }
  }
}
