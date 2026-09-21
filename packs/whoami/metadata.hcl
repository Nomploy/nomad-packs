app {
  url = "https://github.com/traefik/whoami"
}

pack {
  name        = "whoami"
  description = "whoami — a tiny HTTP service that echoes back the request (headers, client IP, hostname). Handy for testing ingress/routing, load balancing, and service discovery. Deployed as a stateless host-networked Nomad service."
  url         = "https://github.com/Nomploy/nomad-packs/tree/main/packs/whoami"
  version     = "0.1.0"
}
