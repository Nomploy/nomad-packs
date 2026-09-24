DBGate deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Open:      http://<node-ip>:[[ var "port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)
Data:      Docker volume "[[ var "data_volume" . ]]" (/root/.dbgate) — saved connections/queries; back it up

Add your database connections from the web UI (MySQL, PostgreSQL, SQL Server, MongoDB, SQLite,
Redis, …). Co-located databases on the same node are reachable at 127.0.0.1. The UI is
unauthenticated by default — keep it on an internal network or front it with a reverse proxy, or set
DBGate's LOGIN/PASSWORD env vars to require a login.
