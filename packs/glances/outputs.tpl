Glances deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Web UI:    http://<node-ip>:[[ var "port" . ]]
REST API:  http://<node-ip>:[[ var "port" . ]]/api/4/all
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)

Runs with pid_mode=host so process/CPU/memory stats reflect the whole node[[ if var "docker_socket" . ]], and
the Docker socket is mounted read-only for per-container stats[[ end ]].

Shows only the node this alloc lands on. For multi-node history + alerting use the
monitoring pack (Prometheus/Grafana). Front the web UI with TLS/auth — Glances has no
built-in auth.
