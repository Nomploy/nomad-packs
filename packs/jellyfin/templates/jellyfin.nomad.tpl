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

    task "jellyfin" {
      driver = "docker"

      config {
        image        = "[[ var "image" . ]]"
        network_mode = "host"
        ports        = ["http"]
        mount {
          type   = "volume"
          target = "/config"
          source = "[[ var "config_volume" . ]]"
        }
        mount {
          type   = "volume"
          target = "/cache"
          source = "[[ var "cache_volume" . ]]"
        }
        mount {
          type   = "volume"
          target = "/media"
          source = "[[ var "media_volume" . ]]"
          readonly = true
        }
      }

      [[- if ne (var "published_server_url" .) "" ]]
      env {
        JELLYFIN_PublishedServerUrl = "[[ var "published_server_url" . ]]"
      }
      [[- end ]]

      resources {
        cpu    = [[ (var "resources" .).cpu ]]
        memory = [[ (var "resources" .).memory ]]
      }
    }
  }
}
