Metabase deployed as job "[[ var "job_name" . ]]" (Metabase + PostgreSQL, host-networked).

Open:      [[ if ne (var "site_url" .) "" ]][[ var "site_url" . ]][[ else ]]http://<node-ip>:[[ var "port" . ]][[ end ]]  (complete the setup wizard + create the admin on first visit)
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad) on port [[ var "port" . ]]
State:     Docker volume "[[ var "db_data_volume" . ]]" (Postgres: dashboards, questions, users) — back this up

First boot is slow (Metabase initializes + migrates its app DB). Then add data sources —
e.g. the postgres pack at 127.0.0.1:5432, clickhouse at :8123, mariadb at :3306.
[[ if eq (var "encryption_key" .) "" ]]Tip: set encryption_key to encrypt stored data-source credentials at rest.[[ end ]]
