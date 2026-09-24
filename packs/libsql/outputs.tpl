libSQL server deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

HTTP API:  http://<node-ip>:[[ var "port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)
Data:      Docker volume "[[ var "data_volume" . ]]" (/var/lib/sqld) — your database; back it up

Connect with a libSQL/Turso client (libsql:// or http://) or any SQLite-compatible libSQL driver. Quick
check: curl http://<node-ip>:[[ var "port" . ]]/health. By default there is NO authentication — set
auth_jwt_key and keep the port internal. This is a single primary node (great for a shared app database).
