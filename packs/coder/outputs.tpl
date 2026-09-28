Coder deployed as job "[[ var "job_name" . ]]" (all-in-one, host-networked on port [[ var "port" . ]]).

Web UI:    http://<node-ip>:[[ var "port" . ]]   (create the first admin account)
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)

PostgreSQL is bundled as a prestart sidecar (port [[ var "db_port" . ]]). Set
access_url to the node's reachable address so workspaces and the CLI can connect
(otherwise Coder opens a temporary *.try.coder.app tunnel). The Docker socket is
mounted so the built-in Docker starter template can create workspaces on the node
(set docker_sock="" to disable). Change db_password before deploying anywhere real.
