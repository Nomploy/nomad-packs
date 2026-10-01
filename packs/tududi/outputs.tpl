Tududi deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Web UI:    http://<node-ip>:[[ var "port" . ]]
Login:     [[ var "admin_email" . ]] / (the admin_password you set)
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)

The admin account is seeded on first start. Change admin_password and
session_secret before deploying anywhere real, and set allowed_origins to the
public URL you serve Tududi from (otherwise the API rejects the browser).
SQLite DB, uploads and backups persist in their volumes.
