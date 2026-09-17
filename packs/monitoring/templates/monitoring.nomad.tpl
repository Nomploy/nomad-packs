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

  # All-in-one observability: Prometheus + Grafana as main tasks, node-exporter
  # and cAdvisor as prestart sidecars. Everything shares the host network, so
  # Prometheus scrapes exporters on 127.0.0.1 and Grafana reaches Prometheus on
  # 127.0.0.1. count stays 1 — Prometheus/Grafana keep local state on volumes.
  group "[[ var "job_name" . ]]" {
    count = 1

    network {
      mode = "host"
      port "prometheus" {
        static = [[ var "prometheus_port" . ]]
      }
      port "grafana" {
        static = [[ var "grafana_port" . ]]
      }
      port "node_exporter" {
        static = [[ var "node_exporter_port" . ]]
      }
      [[- if var "enable_cadvisor" . ]]
      port "cadvisor" {
        static = [[ var "cadvisor_port" . ]]
      }
      [[- end ]]
    }

    service {
      name     = "[[ var "job_name" . ]]-grafana"
      provider = "nomad"
      port     = "grafana"
    }

    service {
      name     = "[[ var "job_name" . ]]-prometheus"
      provider = "nomad"
      port     = "prometheus"
    }

    restart {
      attempts = 3
      interval = "5m"
      delay    = "15s"
      mode     = "delay"
    }

    # --- node-exporter (prestart sidecar) ---------------------------------
    task "node-exporter" {
      driver = "docker"

      lifecycle {
        hook    = "prestart"
        sidecar = true
      }

      config {
        image        = "[[ var "node_exporter_image" . ]]"
        network_mode = "host"
        ports        = ["node_exporter"]
        args = [
          "--path.procfs=/host/proc",
          "--path.sysfs=/host/sys",
          "--path.rootfs=/rootfs",
          "--web.listen-address=:[[ var "node_exporter_port" . ]]",
          "--collector.filesystem.mount-points-exclude=^/(sys|proc|dev|host|etc)($$|/)",
        ]
        volumes = [
          "/proc:/host/proc:ro",
          "/sys:/host/sys:ro",
          "/:/rootfs:ro",
        ]
      }

      resources {
        cpu    = [[ (var "exporter_resources" .).cpu ]]
        memory = [[ (var "exporter_resources" .).memory ]]
      }
    }

    [[- if var "enable_cadvisor" . ]]
    # --- cAdvisor (prestart sidecar) --------------------------------------
    task "cadvisor" {
      driver = "docker"

      lifecycle {
        hook    = "prestart"
        sidecar = true
      }

      config {
        image        = "[[ var "cadvisor_image" . ]]"
        network_mode = "host"
        ports        = ["cadvisor"]
        args         = ["--port=[[ var "cadvisor_port" . ]]"]
        volumes = [
          "/:/rootfs:ro",
          "/var/run:/var/run:ro",
          "/sys:/sys:ro",
          "/var/lib/docker/:/var/lib/docker:ro",
        ]
      }

      resources {
        cpu    = [[ (var "exporter_resources" .).cpu ]]
        memory = [[ (var "exporter_resources" .).memory ]]
      }
    }
    [[- end ]]

    # --- Prometheus (main) ------------------------------------------------
    task "prometheus" {
      driver = "docker"

      config {
        image        = "[[ var "prometheus_image" . ]]"
        network_mode = "host"
        ports        = ["prometheus"]
        args = [
          "--config.file=/local/prometheus.yml",
          "--storage.tsdb.path=/prometheus",
          "--storage.tsdb.retention.time=[[ var "retention" . ]]",
          "--web.listen-address=:[[ var "prometheus_port" . ]]",
        ]

        # Fresh named volume inherits the image's /prometheus ownership (uid
        # 65534), so Prometheus can write its TSDB.
        mount {
          type   = "volume"
          source = "[[ var "prometheus_data_volume" . ]]"
          target = "/prometheus"
        }
      }

      template {
        destination = "local/prometheus.yml"
        data        = <<EOH
global:
  scrape_interval: [[ var "scrape_interval" . ]]

scrape_configs:
  - job_name: prometheus
    static_configs:
      - targets: ['127.0.0.1:[[ var "prometheus_port" . ]]']

  - job_name: node
    static_configs:
      - targets: ['127.0.0.1:[[ var "node_exporter_port" . ]]']
[[- if var "enable_cadvisor" . ]]

  - job_name: cadvisor
    static_configs:
      - targets: ['127.0.0.1:[[ var "cadvisor_port" . ]]']
[[- end ]]
[[- if ne (var "nomad_metrics_url" .) "" ]]

  - job_name: nomad
    metrics_path: /v1/metrics
    params:
      format: ['prometheus']
    static_configs:
      - targets: ['[[ var "nomad_metrics_url" . ]]']
[[- end ]]
EOH
      }

      resources {
        cpu    = [[ (var "prometheus_resources" .).cpu ]]
        memory = [[ (var "prometheus_resources" .).memory ]]
      }
    }

    # --- Grafana (main) ---------------------------------------------------
    task "grafana" {
      driver = "docker"

      config {
        image        = "[[ var "grafana_image" . ]]"
        network_mode = "host"
        ports        = ["grafana"]

        mount {
          type   = "volume"
          source = "[[ var "grafana_data_volume" . ]]"
          target = "/var/lib/grafana"
        }
      }

      # Pre-wire the Prometheus datasource so Grafana works out of the box.
      template {
        destination = "local/provisioning/datasources/prometheus.yaml"
        data        = <<EOH
apiVersion: 1
datasources:
  - name: Prometheus
    type: prometheus
    access: proxy
    url: http://127.0.0.1:[[ var "prometheus_port" . ]]
    isDefault: true
    editable: true
EOH
      }

      env {
        GF_PATHS_PROVISIONING      = "/local/provisioning"
        GF_SERVER_HTTP_PORT        = "[[ var "grafana_port" . ]]"
        GF_SECURITY_ADMIN_USER     = "[[ var "grafana_admin_user" . ]]"
        GF_SECURITY_ADMIN_PASSWORD = "[[ var "grafana_admin_password" . ]]"
        [[- if ne (var "grafana_root_url" .) "" ]]
        GF_SERVER_ROOT_URL         = "[[ var "grafana_root_url" . ]]"
        [[- end ]]
      }

      resources {
        cpu    = [[ (var "grafana_resources" .).cpu ]]
        memory = [[ (var "grafana_resources" .).memory ]]
      }
    }
  }
}
