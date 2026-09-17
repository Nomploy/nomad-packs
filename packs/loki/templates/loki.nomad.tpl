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

  # All-in-one logs: Loki (main) with a prestart chown init, plus an optional
  # Alloy shipper (prestart sidecar) that tails this node's Docker containers via
  # the socket and pushes to Loki on 127.0.0.1. count stays 1 — filesystem
  # storage lives on a local volume.
  group "[[ var "job_name" . ]]" {
    count = 1

    network {
      mode = "host"
      port "loki" {
        static = [[ var "loki_port" . ]]
      }
      [[- if var "enable_alloy" . ]]
      port "alloy" {
        static = [[ var "alloy_port" . ]]
      }
      [[- end ]]
    }

    service {
      name     = "[[ var "job_name" . ]]"
      provider = "nomad"
      port     = "loki"
    }

    restart {
      attempts = 3
      interval = "5m"
      delay    = "15s"
      mode     = "delay"
    }

    # --- chown the data volume so Loki (uid 10001) can write it -----------
    task "init" {
      driver = "docker"

      lifecycle {
        hook    = "prestart"
        sidecar = false
      }

      config {
        image   = "busybox:latest"
        command = "sh"
        args    = ["-c", "mkdir -p /loki/chunks /loki/rules /loki/compactor && chown -R 10001:10001 /loki"]

        mount {
          type   = "volume"
          source = "[[ var "loki_data_volume" . ]]"
          target = "/loki"
        }
      }

      resources {
        cpu    = 50
        memory = 64
      }
    }

    [[- if var "enable_alloy" . ]]
    # --- Alloy log shipper (prestart sidecar) -----------------------------
    task "alloy" {
      driver = "docker"

      lifecycle {
        hook    = "prestart"
        sidecar = true
      }

      config {
        image        = "[[ var "alloy_image" . ]]"
        network_mode = "host"
        ports        = ["alloy"]
        args = [
          "run",
          "/local/config.alloy",
          "--server.http.listen-addr=0.0.0.0:[[ var "alloy_port" . ]]",
          "--storage.path=/tmp/alloy",
        ]
        # Alloy reads container logs through the Docker API.
        volumes = ["/var/run/docker.sock:/var/run/docker.sock:ro"]
      }

      template {
        destination = "local/config.alloy"
        data        = <<EOH
discovery.docker "containers" {
  host = "unix:///var/run/docker.sock"
}

discovery.relabel "containers" {
  targets = discovery.docker.containers.targets

  rule {
    source_labels = ["__meta_docker_container_name"]
    regex         = "/(.*)"
    target_label  = "container"
  }
}

loki.source.docker "default" {
  host       = "unix:///var/run/docker.sock"
  targets    = discovery.relabel.containers.output
  labels     = { job = "docker" }
  forward_to = [loki.write.default.receiver]
}

loki.write "default" {
  endpoint {
    url = "http://127.0.0.1:[[ var "loki_port" . ]]/loki/api/v1/push"
  }
}
EOH
      }

      resources {
        cpu    = [[ (var "alloy_resources" .).cpu ]]
        memory = [[ (var "alloy_resources" .).memory ]]
      }
    }
    [[- end ]]

    # --- Loki (main) ------------------------------------------------------
    task "loki" {
      driver = "docker"

      config {
        image        = "[[ var "loki_image" . ]]"
        network_mode = "host"
        ports        = ["loki"]
        args         = ["-config.file=/local/loki-config.yaml"]

        mount {
          type   = "volume"
          source = "[[ var "loki_data_volume" . ]]"
          target = "/loki"
        }
      }

      template {
        destination = "local/loki-config.yaml"
        data        = <<EOH
auth_enabled: false

server:
  http_listen_port: [[ var "loki_port" . ]]

common:
  instance_addr: 127.0.0.1
  path_prefix: /loki
  storage:
    filesystem:
      chunks_directory: /loki/chunks
      rules_directory: /loki/rules
  replication_factor: 1
  ring:
    kvstore:
      store: inmemory

schema_config:
  configs:
    - from: 2024-01-01
      store: tsdb
      object_store: filesystem
      schema: v13
      index:
        prefix: index_
        period: 24h

compactor:
  working_directory: /loki/compactor
  retention_enabled: true
  delete_request_store: filesystem

limits_config:
  retention_period: [[ var "retention" . ]]

analytics:
  reporting_enabled: false
EOH
      }

      resources {
        cpu    = [[ (var "loki_resources" .).cpu ]]
        memory = [[ (var "loki_resources" .).memory ]]
      }
    }
  }
}
