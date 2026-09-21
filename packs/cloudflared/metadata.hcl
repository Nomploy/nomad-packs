app {
  url = "https://developers.cloudflare.com/cloudflare-one/connections/connect-networks/"
}

pack {
  name        = "cloudflared"
  description = "cloudflared — run a Cloudflare Tunnel to expose your Nomad services to the internet over an outbound-only connection, no open inbound ports or public IP required. Deployed as a stateless host-networked Nomad service driven by a tunnel token."
  url         = "https://github.com/Nomploy/nomad-packs/tree/main/packs/cloudflared"
  version     = "0.1.0"
}
