app {
  url = "https://conduit.rs"
}

pack {
  name        = "conduit"
  description = "Conduit — a lightweight, self-hosted Matrix homeserver written in Rust: run your own end-to-end-encrypted chat with federation, in a single binary with an embedded database (no PostgreSQL needed). Deployed as a host-networked Nomad service with a persistent data volume."
  url         = "https://github.com/Nomploy/nomad-packs/tree/main/packs/conduit"
  version     = "0.1.0"
}
