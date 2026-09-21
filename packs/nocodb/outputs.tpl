NocoDB deployed as job "[[ var "job_name" . ]]" (NocoDB + PostgreSQL, host-networked).

Open:      [[ if ne (var "public_url" .) "" ]][[ var "public_url" . ]][[ else ]]http://<node-ip>:[[ var "port" . ]][[ end ]]  (create the super-admin account on first visit)
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad) on port [[ var "port" . ]]
State:     volumes "[[ var "db_data_volume" . ]]" (Postgres metadata) + "[[ var "data_volume" . ]]" (uploads) — back both up

First boot migrates the metadata DB. Front with a reverse proxy for TLS; set public_url and
a stable jwt_secret for production.
