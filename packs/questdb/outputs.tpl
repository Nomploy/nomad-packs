QuestDB deployed as job "[[ var "job_name" . ]]" (host-networked).

Web console: http://<node-ip>:[[ var "http_port" . ]]
Postgres:    postgresql://admin:quest@<node-ip>:[[ var "pg_port" . ]]/qdb  (default creds admin/quest)
ILP ingest:  <node-ip>:[[ var "ilp_port" . ]]  (InfluxDB Line Protocol, TCP)
Discovery:   Nomad service "[[ var "job_name" . ]]" (provider=nomad)

Data lives on the [[ var "data_volume" . ]] volume (/var/lib/questdb) — back it up and pin the job
to that node with the constraints variable. Change the default PG password for anything exposed.
