app {
  url = "https://github.com/google/cadvisor"
}

pack {
  name        = "cadvisor"
  description = "cAdvisor — Google's Container Advisor: exposes live per-container resource usage and performance metrics (CPU, memory, network, filesystem) with a built-in UI and a Prometheus endpoint. Deployed as a host-networked Nomad service that reads the host and Docker read-only. Run one per node and scrape it with the monitoring pack."
  url         = "https://github.com/Nomploy/nomad-packs/tree/main/packs/cadvisor"
  version     = "0.1.0"
}
