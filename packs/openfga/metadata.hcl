app {
  url = "https://openfga.dev"
}

pack {
  name        = "openfga"
  description = "OpenFGA — a high-performance, flexible authorization engine inspired by Google Zanzibar. Model relationships and permissions (\"can user X view document Y?\") and check them at scale over gRPC/HTTP, with a built-in playground. Deployed as a host-networked Nomad service using an embedded SQLite datastore with a persistent volume."
  url         = "https://github.com/Nomploy/nomad-packs/tree/main/packs/openfga"
  version     = "0.1.0"
}
