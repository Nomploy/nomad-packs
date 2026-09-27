listmonk deployed as job "[[ var "job_name" . ]]" (all-in-one, host-networked on port [[ var "port" . ]]).

Web UI:    http://<node-ip>:[[ var "port" . ]]
Login:     [[ var "admin_user" . ]] / (the admin_password you set)
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)

PostgreSQL is bundled as a prestart sidecar (port [[ var "db_port" . ]]). The
schema is installed automatically on first start and migrated on upgrades.
Change db_password and admin_password before deploying anywhere real, then
configure your SMTP server under Settings to start sending.
