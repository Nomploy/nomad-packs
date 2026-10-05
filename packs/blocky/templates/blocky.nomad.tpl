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
      port "dns" {
        static = [[ var "dns_port" . ]]
      }
      port "http" {
        static = [[ var "http_port" . ]]
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

    task "blocky" {
      driver = "docker"

      config {
        image        = "[[ var "image" . ]]"
        network_mode = "host"
        ports        = ["dns", "http"]
        volumes      = ["local/config.yml:/app/config.yml"]
      }

      template {
        destination = "local/config.yml"
        data        = <<EOH
upstreams:
  groups:
    default:
[[- range $u := var "upstreams" . ]]
      - [[ $u ]]
[[- end ]]

blocking:
  denylists:
    ads:
[[- range $b := var "blocklists" . ]]
      - [[ $b ]]
[[- end ]]
  clientGroupsBlock:
    default:
      - ads

caching:
  minTime: 5m
  maxTime: 30m

ports:
  dns: [[ var "dns_port" . ]]
  http: [[ var "http_port" . ]]
EOH
      }

      resources {
        cpu    = [[ (var "resources" .).cpu ]]
        memory = [[ (var "resources" .).memory ]]
      }
    }
  }
}
