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

    task "ntfy" {
      driver = "docker"

      config {
        image        = "[[ var "image" . ]]"
        network_mode = "host"
        ports        = ["http"]
        args         = ["serve"]

        mount {
          type   = "volume"
          source = "[[ var "data_volume" . ]]"
          target = "/var/lib/ntfy"
        }
      }

      env {
        NTFY_LISTEN_HTTP          = ":[[ var "port" . ]]"
        NTFY_CACHE_FILE           = "/var/lib/ntfy/cache.db"
        NTFY_AUTH_FILE            = "/var/lib/ntfy/auth.db"
        NTFY_ATTACHMENT_CACHE_DIR = "/var/lib/ntfy/attachments"
        [[- if ne (var "base_url" .) "" ]]
        NTFY_BASE_URL             = "[[ var "base_url" . ]]"
        [[- end ]]
        [[- if var "behind_proxy" . ]]
        NTFY_BEHIND_PROXY         = "true"
        [[- end ]]
      }

      resources {
        cpu    = [[ (var "resources" .).cpu ]]
        memory = [[ (var "resources" .).memory ]]
      }
    }
  }
}
