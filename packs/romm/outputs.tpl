RomM deployed as job "[[ var "job_name" . ]]" (all-in-one, host-networked on port [[ var "port" . ]]).

Web UI:    http://<node-ip>:[[ var "port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)

Bundled: MariaDB (prestart sidecar, port [[ var "db_port" . ]]). The RomM image bundles
its own Redis (data in the romm_redis_data volume), so no separate Redis task is needed.
Database migrations run automatically on first start; create the first admin account in
the UI.

Put your ROMs in the library_volume (/romm/library) — for real use, point library_volume
at a host path that holds your game files. CHANGE db_password, db_root_password and
auth_secret_key before deploying anywhere real, and keep auth_secret_key stable. Add
igdb_client_id / igdb_client_secret (or other metadata provider keys) to enable artwork
and metadata scraping.
