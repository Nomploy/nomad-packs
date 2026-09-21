Miniflux deployed as job "[[ var "job_name" . ]]" (Miniflux + PostgreSQL, host-networked).

Open:      [[ if ne (var "base_url" .) "" ]][[ var "base_url" . ]][[ else ]]http://<node-ip>:[[ var "port" . ]][[ end ]]  (login [[ var "admin_user" . ]] / <admin_password>)
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad) on port [[ var "port" . ]]
State:     Docker volume "[[ var "db_data_volume" . ]]" (Postgres: feeds, entries, users) — back it up

First boot runs migrations and creates the admin. Change the password; front with a reverse
proxy for TLS and set base_url when using a domain.
