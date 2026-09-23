app {
  url = "https://www.mysql.com"
}

pack {
  name        = "mysql"
  description = "MySQL — the world's most popular open-source relational database (Oracle's official build). Deployed as a host-networked Nomad service with a persistent Docker volume. Use it when an app specifically needs Oracle MySQL; otherwise the mariadb pack is a drop-in."
  url         = "https://github.com/Nomploy/nomad-packs/tree/main/packs/mysql"
  version     = "0.1.0"
}
