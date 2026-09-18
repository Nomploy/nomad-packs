Plausible deployed as job "[[ var "job_name" . ]]" (Plausible + PostgreSQL + ClickHouse, host-networked).

Open:      [[ if ne (var "base_url" .) "" ]][[ var "base_url" . ]][[ else ]]http://<node-ip>:[[ var "port" . ]][[ end ]]  (register the first/admin account, then lock down registration)
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad) on port [[ var "port" . ]]
State:     volumes "[[ var "db_data_volume" . ]]" (Postgres) + "[[ var "clickhouse_data_volume" . ]]" (ClickHouse events) — back both up

First boot creates + migrates the databases (slow). Add your site in the UI to get the
tracking snippet. Set base_url and front with a reverse proxy for TLS. Change
SECRET_KEY_BASE (>= 64 chars) and the DB password.
