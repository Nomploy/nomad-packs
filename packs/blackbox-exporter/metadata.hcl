app {
  url = "https://github.com/prometheus/blackbox_exporter"
}

pack {
  name        = "blackbox-exporter"
  description = "Prometheus Blackbox Exporter — probes endpoints over HTTP, HTTPS, TCP, DNS, and ICMP and exposes the results for Prometheus (uptime, latency, cert expiry). Deployed as a stateless host-networked Nomad service with a rendered module config. Pairs with the monitoring pack."
  url         = "https://github.com/Nomploy/nomad-packs/tree/main/packs/blackbox-exporter"
  version     = "0.1.0"
}
