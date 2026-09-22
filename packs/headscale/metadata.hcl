app {
  url = "https://headscale.net"
}

pack {
  name        = "headscale"
  description = "Headscale — an open-source, self-hosted implementation of the Tailscale control server. Run your own coordination server for a WireGuard-based mesh VPN, with no dependency on Tailscale's SaaS. Deployed as a host-networked Nomad service with a rendered config and a SQLite data volume."
  url         = "https://github.com/Nomploy/nomad-packs/tree/main/packs/headscale"
  version     = "0.1.0"
}
