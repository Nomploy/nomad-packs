Keycloak deployed as job "[[ var "job_name" . ]]" (Keycloak + PostgreSQL, host-networked).

Admin console: [[ if ne (var "hostname" .) "" ]][[ var "hostname" . ]]/admin[[ else ]]http://<node-ip>:[[ var "port" . ]]/admin[[ end ]]
Login:         [[ var "admin_user" . ]] / <admin_password>  (rotate it after first login)
Discovery:     Nomad service "[[ var "job_name" . ]]" (provider=nomad) on port [[ var "port" . ]]
State:         Docker volume "[[ var "db_data_volume" . ]]" (Postgres: realms, users, clients) — back this up

Serves plain HTTP; front it with a reverse proxy for TLS. First boot is slow (Keycloak
builds + migrates the DB). OIDC discovery once a realm exists:
  [[ if ne (var "hostname" .) "" ]][[ var "hostname" . ]][[ else ]]http://<node-ip>:[[ var "port" . ]][[ end ]]/realms/<realm>/.well-known/openid-configuration
