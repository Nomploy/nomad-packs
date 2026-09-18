Dozzle deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Open:      http://<node-ip>:[[ var "port" . ]]  (live logs for every container on this node)
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)

Stateless — no volume. It shows containers on the node it runs on; pin it (constraints) to
the node whose logs you want. No auth by default — keep it internal or set DOZZLE_AUTH_*.
