immudb deployed as job "[[ var "job_name" . ]]" (host-networked).

DB:        <node-ip>:[[ var "port" . ]]  (immudb / your IMMUDB_ADMIN_PASSWORD)
Console:   http://<node-ip>:[[ var "web_port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)
Data:      Docker volume "[[ var "data_volume" . ]]" (/var/lib/immudb) — verifiable history; back it up

Connect with the immuclient CLI or SDKs (Go, Python, Java, Node, .NET), or via the PostgreSQL/MySQL wire
protocol. Every write is cryptographically appended and can be verified — great for audit logs and
tamper-evident records. Change the admin password on first login. Keep the port on an internal network.
