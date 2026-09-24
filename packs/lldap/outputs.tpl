LLDAP deployed as job "[[ var "job_name" . ]]" (host-networked).

Web UI:    http://<node-ip>:[[ var "web_port" . ]]  (log in as "admin")
LDAP:      ldap://<node-ip>:[[ var "ldap_port" . ]]  (base DN [[ var "base_dn" . ]])
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)
Data:      Docker volume "[[ var "data_volume" . ]]" (/data: SQLite DB + private key) — back it up

Log in to the web UI with admin / your LLDAP_LDAP_USER_PASS, then create users and groups. Point apps
at the LDAP endpoint with a bind user like uid=admin,ou=people,[[ var "base_dn" . ]]. Serves plain LDAP/
HTTP — keep it internal or front the web UI with a reverse proxy for TLS (LDAPS needs extra config).
