Netdata deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Open:      http://<node-ip>:[[ var "port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)
Data:      Docker volumes "[[ var "config_volume" . ]]", "[[ var "lib_volume" . ]]", "[[ var "cache_volume" . ]]"

The agent auto-detects the host's CPU, memory, disks, network, and running Docker containers (via
the read-only docker.sock) with per-second resolution. The dashboard is unauthenticated — keep it on
an internal network or front it with a reverse proxy. Run one instance per node you want to monitor.
