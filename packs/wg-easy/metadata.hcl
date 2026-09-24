app {
  url = "https://github.com/wg-easy/wg-easy"
}

pack {
  name        = "wg-easy"
  description = "wg-easy — the easiest way to run a WireGuard VPN with a web UI: create clients, show QR codes for phones, and see live traffic, all from the browser. Deployed as a host-networked Nomad service with the NET_ADMIN capability and IP forwarding enabled, plus a persistent config volume."
  url         = "https://github.com/Nomploy/nomad-packs/tree/main/packs/wg-easy"
  version     = "0.1.0"
}
