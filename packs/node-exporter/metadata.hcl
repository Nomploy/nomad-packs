app {
  url = "https://github.com/prometheus/node_exporter"
}

pack {
  name        = "node-exporter"
  description = "Prometheus Node Exporter — exposes a node's hardware and OS metrics (CPU, memory, disk, filesystem, network, load) at a /metrics endpoint for Prometheus to scrape. Deployed as a host-networked Nomad service that reads the host read-only; run one per node and point the monitoring pack at it."
  url         = "https://github.com/Nomploy/nomad-packs/tree/main/packs/node-exporter"
  version     = "0.1.0"
}
