Directus deployed as job "[[ var "job_name" . ]]" (Directus + PostgreSQL, host-networked).

Open:      [[ if ne (var "public_url" .) "" ]][[ var "public_url" . ]][[ else ]]http://<node-ip>:[[ var "port" . ]][[ end ]]  (login [[ var "admin_email" . ]] / <admin_password>)
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad) on port [[ var "port" . ]]
State:     volumes "[[ var "db_data_volume" . ]]" (Postgres) + "[[ var "uploads_volume" . ]]" (files) — back both up

First boot bootstraps the schema + admin. Change KEY/SECRET (keep them stable) and the admin
password; front with a reverse proxy for TLS and set public_url.
