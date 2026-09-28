Dagu deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Web UI:    http://<node-ip>:[[ var "port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)

Define workflows as YAML DAGs from the web UI or under /var/lib/dagu/dags. The
Docker socket is bind-mounted so DAGs can run Docker containers on the node
(set docker_sock="" to disable). Everything (DAGs, logs, state) persists in the
data_volume.
