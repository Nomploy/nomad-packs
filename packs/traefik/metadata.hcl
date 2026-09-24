app {
  url = "https://traefik.io"
}

pack {
  name        = "traefik"
  description = "Traefik — a modern reverse proxy and load balancer that auto-discovers your services and routes traffic to them, with a live dashboard. This pack wires Traefik to Nomad's native service provider, so jobs tagged for Traefik get routed automatically. Deployed as a host-networked Nomad service."
  url         = "https://github.com/Nomploy/nomad-packs/tree/main/packs/traefik"
  version     = "0.1.0"
}
