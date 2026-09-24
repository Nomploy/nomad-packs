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
        static = [[ var "web_port" . ]]
      }
      port "wg" {
        static = [[ var "wg_port" . ]]
      }
    }

    service {
      name     = "[[ var "job_name" . ]]"
      provider = "nomad"
      port     = "web"
    }

    restart {
      attempts = 3
      interval = "5m"
      delay    = "15s"
      mode     = "delay"
    }

    task "wg-easy" {
      driver = "docker"

      config {
        image        = "[[ var "image" . ]]"
        network_mode = "host"
        ports        = ["web", "wg"]

        cap_add = ["NET_ADMIN", "SYS_MODULE"]

        sysctl = {
          "net.ipv4.ip_forward"              = "1"
          "net.ipv4.conf.all.src_valid_mark" = "1"
        }

        mount {
          type   = "volume"
          source = "[[ var "data_volume" . ]]"
          target = "/etc/wireguard"
        }
      }

      env {
        WG_HOST  = "[[ var "wg_host" . ]]"
        PASSWORD = "[[ var "password" . ]]"
        PORT     = "[[ var "web_port" . ]]"
        WG_PORT  = "[[ var "wg_port" . ]]"
      }

      resources {
        cpu    = [[ (var "resources" .).cpu ]]
        memory = [[ (var "resources" .).memory ]]
      }
    }
  }
}
