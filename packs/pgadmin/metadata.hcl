app {
  url = "https://www.pgadmin.org"
}

pack {
  name        = "pgadmin"
  description = "pgAdmin 4 — the popular web-based administration and development tool for PostgreSQL. Deployed as a host-networked Nomad service with a persistent Docker volume for its saved servers and settings. Pairs with the postgres pack."
  url         = "https://github.com/Nomploy/nomad-packs/tree/main/packs/pgadmin"
  version     = "0.1.0"
}
