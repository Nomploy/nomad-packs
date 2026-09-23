app {
  url = "https://github.com/favonia/cloudflare-ddns"
}

pack {
  name        = "cloudflare-ddns"
  description = "Cloudflare DDNS — a small, robust dynamic-DNS updater that keeps your Cloudflare A/AAAA records pointed at your current public IP. Deployed as a background host-networked Nomad service (no ports, no volume); set your API token and domains."
  url         = "https://github.com/Nomploy/nomad-packs/tree/main/packs/cloudflare-ddns"
  version     = "0.1.0"
}
