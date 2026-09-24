cAdvisor deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

UI:        http://<node-ip>:[[ var "port" . ]]
Metrics:   http://<node-ip>:[[ var "port" . ]]/metrics  (Prometheus format)
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)

Exposes live per-container CPU/memory/network/filesystem metrics. Point Prometheus (the "monitoring" pack) at
/metrics and visualize in Grafana. Reads the host and Docker read-only; run one instance per node. The
endpoint is unauthenticated — keep it on an internal network.
