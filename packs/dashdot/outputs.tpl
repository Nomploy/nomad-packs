dashdot deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Open:      http://<node-ip>:[[ var "port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)

Shows live CPU, memory, storage, network, and OS info for this node. It reads the host at /mnt/host
(read-only) for accurate storage stats and uses host networking for network throughput. Some extras (disk
temperatures, certain SMART data) need a privileged container, which this pack does not request. It's an
unauthenticated dashboard — keep it internal or front it with a reverse proxy.
