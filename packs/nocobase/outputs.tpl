NocoBase deployed as job "[[ var "job_name" . ]]" (all-in-one, host-networked on port [[ var "port" . ]]).

Web UI:    http://<node-ip>:[[ var "port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)

PostgreSQL is bundled as a prestart sidecar (port [[ var "db_port" . ]]). First
boot installs the built-in plugins and seeds the admin (default admin@nocobase.com
/ admin — change it immediately). Change db_password and app_key before deploying
anywhere real, and keep app_key stable (it encrypts stored data). Uploads persist
in the storage_volume; everything else in PostgreSQL.
