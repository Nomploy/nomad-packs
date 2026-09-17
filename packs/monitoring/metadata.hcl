app {
  url = "https://prometheus.io"
}

pack {
  name        = "monitoring"
  description = "One-click observability stack: Prometheus + node-exporter + cAdvisor + Grafana in a single host-networked Nomad job. Gives you host and per-container metrics (filling the cgroup-v2 per-alloc gap), with Grafana pre-wired to Prometheus."
  url         = "https://github.com/Nomploy/nomad-packs/tree/main/packs/monitoring"
  version     = "0.1.0"
}
