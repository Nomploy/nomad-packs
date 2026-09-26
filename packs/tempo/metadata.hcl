app {
  url = "https://grafana.com/oss/tempo/"
}

pack {
  name        = "tempo"
  description = "Grafana Tempo — a high-scale, cost-efficient distributed tracing backend with OTLP ingestion and local block storage. Query traces from Grafana. Deployed as a single host-networked Nomad service."
  url         = "https://github.com/Nomploy/nomad-packs/tree/main/packs/tempo"
  version     = "0.1.0"
}
