app {
  url = "https://immudb.io"
}

pack {
  name        = "immudb"
  description = "immudb — a lightweight, high-speed immutable database with built-in cryptographic verification: data can be appended and read but not silently changed or deleted, so you get tamper-evident history for audit logs, transactions, and compliance. Speaks SQL and key-value. Deployed as a host-networked Nomad service with a persistent data volume."
  url         = "https://github.com/Nomploy/nomad-packs/tree/main/packs/immudb"
  version     = "0.1.0"
}
