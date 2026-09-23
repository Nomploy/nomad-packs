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
    }

    restart {
      attempts = 3
      interval = "5m"
      delay    = "15s"
      mode     = "delay"
    }

    task "cloudflare-ddns" {
      driver = "docker"

      config {
        image        = "[[ var "image" . ]]"
        network_mode = "host"
      }

      env {
        CLOUDFLARE_API_TOKEN = "[[ var "api_token" . ]]"
        DOMAINS              = "[[ var "domains" . ]]"
        PROXIED              = "[[ var "proxied" . ]]"
        IP6_PROVIDER         = "[[ var "ip6_provider" . ]]"
      }

      resources {
        cpu    = [[ (var "resources" .).cpu ]]
        memory = [[ (var "resources" .).memory ]]
      }
    }
  }
}
