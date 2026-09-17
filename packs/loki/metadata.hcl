app {
  url = "https://grafana.com/oss/loki/"
}

pack {
  name        = "loki"
  description = "Grafana Loki — log aggregation — deployed all-in-one with a Grafana Alloy shipper that tails this node's Docker container logs and pushes them to Loki. Single host-networked Nomad job, filesystem storage on a persistent volume. Pairs with the monitoring pack."
  url         = "https://github.com/Nomploy/nomad-packs/tree/main/packs/loki"
  version     = "0.1.0"
}
