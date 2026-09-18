Umami deployed as job "[[ var "job_name" . ]]" (Umami + PostgreSQL, host-networked).

Open:      http://<node-ip>:[[ var "port" . ]]  (default login: admin / umami — change it immediately)
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad) on port [[ var "port" . ]]
State:     Docker volume "[[ var "db_data_volume" . ]]" (Postgres: sites, events) — back this up

First boot runs DB migrations, then serves. Add your website in the UI to get the tracking
snippet. Front it with a reverse proxy for TLS.
