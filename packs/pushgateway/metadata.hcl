app {
  url = "https://github.com/prometheus/pushgateway"
}

pack {
  name        = "pushgateway"
  description = "Prometheus Pushgateway — lets short-lived and batch jobs push their metrics to an intermediary that Prometheus then scrapes. Deployed as a stateless host-networked Nomad service. Pairs with the monitoring pack."
  url         = "https://github.com/Nomploy/nomad-packs/tree/main/packs/pushgateway"
  version     = "0.1.0"
}
