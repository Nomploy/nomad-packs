app {
  url = "https://github.com/prometheus-community/postgres_exporter"
}

pack {
  name        = "postgres-exporter"
  description = "Prometheus Postgres Exporter — scrapes a PostgreSQL server and exposes database, table, and replication metrics for Prometheus. Deployed as a stateless host-networked Nomad service; point it at any reachable Postgres via a DSN. Pairs with the postgres and monitoring packs."
  url         = "https://github.com/Nomploy/nomad-packs/tree/main/packs/postgres-exporter"
  version     = "0.1.0"
}
