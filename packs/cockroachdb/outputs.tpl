CockroachDB deployed as job "[[ var "job_name" . ]]" (single-node, insecure, host-networked).

SQL:        postgresql://root@<node-ip>:[[ var "sql_port" . ]]/defaultdb?sslmode=disable
DB Console: http://<node-ip>:[[ var "http_port" . ]]
Discovery:  Nomad service "[[ var "job_name" . ]]" (provider=nomad)

Connect with any Postgres client (user "root", no password in insecure mode) or:
  cockroach sql --insecure --host=<node-ip>:[[ var "sql_port" . ]]

Data is on the [[ var "data_volume" . ]] volume (/cockroach/cockroach-data) — back it up and pin
the job to that node with the constraints variable.

WARNING: --insecure = no auth and no TLS. Use only on a trusted network; for production run a
secure, multi-node cluster with certificates.
