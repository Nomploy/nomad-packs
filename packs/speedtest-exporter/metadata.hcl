app {
  url = "https://github.com/MiguelNdeCarvalho/speedtest-exporter"
}

pack {
  name        = "speedtest-exporter"
  description = "Speedtest Exporter — runs periodic internet speed tests and exposes the results as Prometheus metrics for graphing in Grafana. Deployed as a single stateless host-networked Nomad service."
  url         = "https://github.com/Nomploy/nomad-packs/tree/main/packs/speedtest-exporter"
  version     = "0.1.0"
}
