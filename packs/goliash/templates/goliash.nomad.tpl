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

    [[- if and (gt (var "canary" .) 0) (ne (var "database_url" .) "") ]]
    # Zero-downtime canary — only with Postgres (stateless, so two allocs can't
    # corrupt a shared volume). Pairs with the dynamic port below so the canary
    # can co-locate on the same node (no static-port conflict / forced node
    # move), keeping Traefik's health-aware cutover clean. Needs public_url set.
    update {
      max_parallel     = 1
      canary           = [[ var "canary" . ]]
      auto_promote     = true
      auto_revert      = true
      min_healthy_time = "10s"
      healthy_deadline = "3m"
    }
    [[- else ]]
    # Default single-alloc replace (brief restart). Set canary>0 WITH database_url
    # for zero-downtime rolls; on the SQLite path a canary would risk the volume.
    [[- end ]]

    network {
      mode = "host"
      [[- if (var "dns_servers" .) ]]
      dns {
        servers = [[ var "dns_servers" . | toStringList ]]
      }
      [[- end ]]
      port "http" {
        [[- if and (gt (var "canary" .) 0) (ne (var "database_url" .) "") ]]
        # Dynamic: Nomad picks a free host port so a canary co-locates; reachable
        # via Traefik/Consul (the domain), not a fixed port.
        [[- else ]]
        static = [[ var "port" . ]]
        [[- end ]]
      }
    }

    service {
      name     = "[[ var "job_name" . ]]"
      provider = "nomad"
      port     = "http"
      [[- if gt (var "metrics_port" .) 0 ]]
      # Opt-in metrics scraping: nomploy's deploy flips this service to the
      # Consul provider and preserves these tags, so the built-in OTel Collector
      # discovers and scrapes /metrics on this port (with the named auth
      # profile's credential, when set).
      tags = [
        "nomploy.metrics.port=[[ var "metrics_port" . ]]",
        [[- if ne (var "metrics_auth_profile" .) "" ]]
        "nomploy.metrics.auth=[[ var "metrics_auth_profile" . ]]",
        [[- end ]]
      ]
      [[- end ]]

      check {
        type     = "http"
        path     = "/healthz"
        interval = "30s"
        timeout  = "5s"
      }
    }

    restart {
      attempts = 3
      interval = "5m"
      delay    = "15s"
      mode     = "delay"
    }

    task "goliash" {
      driver = "docker"

      config {
        image        = "[[ var "image" . ]]"
        network_mode = "host"
        ports        = ["http"]
        args         = ["serve"]
        [[- if eq (var "database_url" .) "" ]]
        mount {
          type   = "volume"
          target = "/data"
          source = "[[ var "data_volume" . ]]"
        }
        [[- end ]]
      }

      env {
        [[- if and (gt (var "canary" .) 0) (ne (var "database_url" .) "") ]]
        GOLIASH_LISTEN         = ":$${NOMAD_PORT_http}"
        [[- else ]]
        GOLIASH_LISTEN         = ":[[ var "port" . ]]"
        [[- end ]]
        GOLIASH_BOOTSTRAP_FILE = "/local/bootstrap.yaml"
        [[- if ne (var "database_url" .) "" ]]
        GOLIASH_DATABASE_URL = "[[ var "database_url" . ]]"
        [[- end ]]
        [[- if ne (var "public_url" .) "" ]]
        GOLIASH_PUBLIC_URL = "[[ var "public_url" . ]]"
        [[- else ]]
        GOLIASH_PUBLIC_URL = "http://$${attr.unique.network.ip-address}:[[ var "port" . ]]"
        [[- end ]]
        [[- if ne (var "push_subject" .) "" ]]
        GOLIASH_PUSH_SUBJECT = "[[ var "push_subject" . ]]"
        [[- else ]]
        GOLIASH_PUSH_SUBJECT = "mailto:[[ var "owner_email" . ]]"
        [[- end ]]
        [[- if ne (var "secret_key" .) "" ]]
        GOLIASH_SECRET_KEY = "[[ var "secret_key" . ]]"
        [[- end ]]
        [[- if ne (var "github_token" .) "" ]]
        GOLIASH_GITHUB_TOKEN = "[[ var "github_token" . ]]"
        [[- end ]]
        [[- if ne (var "nomad_token" .) "" ]]
        GOLIASH_CREDENTIAL_NOMAD = "[[ var "nomad_token" . ]]"
        [[- end ]]
      }

      # Created on first start only: changes made later in the UI are kept.
      template {
        destination = "local/bootstrap.yaml"
        data        = <<EOH
owner: "[[ var "owner_email" . ]]"
environments:
  - name: "[[ var "environment" . ]]"
    position: 30
[[- if var "watch_nomad" . ]]
targets:
  - name: "[[ var "job_name" . ]]-nomad"
    environment: "[[ var "environment" . ]]"
    platform: nomad
    poll_interval_seconds: 60
    settings:
[[- if ne (var "nomad_token" .) "" ]]
      credentials_ref: nomad
[[- end ]]
      nomad:
[[- if ne (var "nomad_address" .) "" ]]
        address: "[[ var "nomad_address" . ]]"
[[- else ]]
        address: "http://{{ env "attr.unique.network.ip-address" }}:4646"
[[- end ]]
[[- end ]]
EOH
      }

      resources {
        cpu    = [[ (var "resources" .).cpu ]]
        memory = [[ (var "resources" .).memory ]]
      }
    }
  }
}
