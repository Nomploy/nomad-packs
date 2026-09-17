app {
  url = "https://github.com/dani-garcia/vaultwarden"
}

pack {
  name        = "vaultwarden"
  description = "Vaultwarden — a lightweight, Rust-based server implementing the Bitwarden API (password manager) for self-hosting. Deployed as a host-networked Nomad service with a persistent Docker volume; uses the bundled SQLite database."
  url         = "https://github.com/Nomploy/nomad-packs/tree/main/packs/vaultwarden"
  version     = "0.1.0"
}
