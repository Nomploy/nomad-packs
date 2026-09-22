TimescaleDB deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Connect:   postgres://[[ var "db_user" . ]]:<db_password>@<node-ip>:[[ var "port" . ]]/[[ var "db_name" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)
Data:      Docker volume "[[ var "data_volume" . ]]" (persists across reschedules) — back it up

The timescaledb extension is preloaded; enable it in your DB with:
  CREATE EXTENSION IF NOT EXISTS timescaledb;
then create hypertables. Speaks standard PostgreSQL, so any pg client/driver works.
