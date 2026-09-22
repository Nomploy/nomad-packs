Docmost deployed as job "[[ var "job_name" . ]]" (Docmost + PostgreSQL + Redis, host-networked).

Open:      [[ if ne (var "app_url" .) "" ]][[ var "app_url" . ]][[ else ]]http://<node-ip>:[[ var "port" . ]][[ end ]]  (create the first workspace + admin account)
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad) on port [[ var "port" . ]]
State:     volumes "[[ var "db_data_volume" . ]]" (Postgres: pages/spaces) + "[[ var "storage_volume" . ]]" (attachments) — back both up

First boot migrates the database. Set a stable app_secret (≥32 chars) and app_url; front
with a reverse proxy for TLS. Redis is ephemeral (queues/websockets only).
