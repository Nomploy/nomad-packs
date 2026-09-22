authentik deployed as job "[[ var "job_name" . ]]" (server + worker + PostgreSQL + Redis, host-networked).

Open:      http://<node-ip>:[[ var "port" . ]]
Setup:     [[ if ne (var "bootstrap_password" .) "" ]]log in as akadmin / <bootstrap_password> (email [[ var "bootstrap_email" . ]])[[ else ]]first-run setup at http://<node-ip>:[[ var "port" . ]]/if/flow/initial-setup/ to set the akadmin password[[ end ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad) on port [[ var "port" . ]]
State:     Docker volume "[[ var "db_data_volume" . ]]" (Postgres: users, apps, flows) — back it up

First boot runs DB migrations (slow). Set a stable secret_key and DB password; front with a
reverse proxy for TLS. Redis is ephemeral (cache/queues).
