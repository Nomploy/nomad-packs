app {
  url = "https://github.com/lldap/lldap"
}

pack {
  name        = "lldap"
  description = "LLDAP — a light, opinionated LDAP server with a friendly web UI for managing users and groups. A simple authentication backend for apps that speak LDAP (Nextcloud, Gitea, Grafana, Authelia, and many more) without the pain of OpenLDAP. Deployed as a host-networked Nomad service using SQLite with a persistent data volume."
  url         = "https://github.com/Nomploy/nomad-packs/tree/main/packs/lldap"
  version     = "0.1.0"
}
