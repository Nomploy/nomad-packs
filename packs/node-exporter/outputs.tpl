Node Exporter deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Metrics:   http://<node-ip>:[[ var "port" . ]]/metrics
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)

Scrape this endpoint from Prometheus (the "monitoring" pack) to chart host CPU, memory, disk, filesystem, and
network in Grafana. It reads the host read-only via /host and uses the host PID namespace. Run ONE instance per
node you want to monitor (pin with constraints). The endpoint is unauthenticated — keep it on an internal network.
