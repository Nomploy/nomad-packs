app {
  url = "https://github.com/prometheus/mysqld_exporter"
}

pack {
  name        = "mysqld-exporter"
  description = "Prometheus MySQLd Exporter — scrapes a MySQL or MariaDB server and exposes connection, query, InnoDB, and replication metrics for Prometheus. Deployed as a stateless host-networked Nomad service; point it at any reachable server. Pairs with the mariadb and monitoring packs."
  url         = "https://github.com/Nomploy/nomad-packs/tree/main/packs/mysqld-exporter"
  version     = "0.1.0"
}
