app {
  url = "https://github.com/coturn/coturn"
}

pack {
  name        = "coturn"
  description = "coturn — a TURN and STUN server that relays WebRTC media when peers can't connect directly (behind NAT/firewalls). Essential for reliable self-hosted video calls and conferencing (Jitsi, Nextcloud Talk, Matrix). Deployed as a host-networked Nomad service with static long-term credentials."
  url         = "https://github.com/Nomploy/nomad-packs/tree/main/packs/coturn"
  version     = "0.1.0"
}
