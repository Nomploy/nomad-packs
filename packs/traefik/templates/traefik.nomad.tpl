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
      port "web" {
        static = [[ var "http_port" . ]]
      }
      port "websecure" {
        static = [[ var "https_port" . ]]
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

    task "traefik" {
      driver = "docker"

      config {
        image        = "[[ var "image" . ]]"
        network_mode = "host"
        ports        = ["web", "websecure", "dashboard"]
        args = [
          "--api.dashboard=true",
          "--api.insecure=true",
          "--entrypoints.web.address=:[[ var "http_port" . ]]",
          "--entrypoints.websecure.address=:[[ var "https_port" . ]]",
          "--entrypoints.traefik.address=:[[ var "dashboard_port" . ]]",
          "--providers.nomad=true",
          "--providers.nomad.endpoint.address=[[ var "nomad_address" . ]]",
          [[- if ne (var "nomad_token" .) "" ]]
          "--providers.nomad.endpoint.token=[[ var "nomad_token" . ]]",
          [[- end ]]
        ]
      }

      resources {
        cpu    = [[ (var "resources" .).cpu ]]
        memory = [[ (var "resources" .).memory ]]
      }
    }
  }
}
