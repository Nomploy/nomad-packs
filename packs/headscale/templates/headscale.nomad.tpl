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
      port "metrics" {
        static = [[ var "metrics_port" . ]]
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

    task "headscale" {
      driver = "docker"

      config {
        image        = "[[ var "image" . ]]"
        network_mode = "host"
        ports        = ["http", "metrics"]
        args         = ["serve"]
        volumes      = ["local/config.yaml:/etc/headscale/config.yaml"]
        mount {
          type   = "volume"
          target = "/var/lib/headscale"
          source = "[[ var "data_volume" . ]]"
        }
      }

      template {
        destination = "local/config.yaml"
        data        = <<EOH
server_url: [[ if ne (var "server_url" .) "" ]][[ var "server_url" . ]][[ else ]]http://localhost:[[ var "port" . ]][[ end ]]
listen_addr: 0.0.0.0:[[ var "port" . ]]
metrics_listen_addr: 0.0.0.0:[[ var "metrics_port" . ]]
grpc_listen_addr: 127.0.0.1:50443
grpc_allow_insecure: false
noise:
  private_key_path: /var/lib/headscale/noise_private.key
prefixes:
  v4: 100.64.0.0/10
  v6: fd7a:115c:a1e0::/48
  allocation: sequential
derp:
  server:
    enabled: false
  urls:
    - https://controlplane.tailscale.com/derpmap/default
  auto_update_enabled: true
  update_frequency: 24h
disable_check_updates: false
ephemeral_node_inactivity_timeout: 30m
database:
  type: sqlite
  sqlite:
    path: /var/lib/headscale/db.sqlite
log:
  level: info
  format: text
dns:
  magic_dns: true
  base_domain: [[ var "base_domain" . ]]
  nameservers:
    global:
      - 1.1.1.1
      - 8.8.8.8
EOH
      }

      resources {
        cpu    = [[ (var "resources" .).cpu ]]
        memory = [[ (var "resources" .).memory ]]
      }
    }
  }
}
