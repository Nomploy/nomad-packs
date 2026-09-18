app {
  url = "https://ntfy.sh"
}

pack {
  name        = "ntfy"
  description = "ntfy — a simple pub/sub notification service: send push notifications to your phone or desktop from any script via a plain HTTP PUT/POST. Deployed as a host-networked Nomad service with a persistent Docker volume for its message cache and users."
  url         = "https://github.com/Nomploy/nomad-packs/tree/main/packs/ntfy"
  version     = "0.1.0"
}
