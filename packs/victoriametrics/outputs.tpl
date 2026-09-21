VictoriaMetrics deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

HTTP API:  http://<node-ip>:[[ var "port" . ]]   (query UI at /vmui)
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)
Data:      Docker volume "[[ var "data_volume" . ]]" (retention [[ var "retention" . ]]) — back it up

Use as a Prometheus remote-write target (in the monitoring pack's prometheus.yml):
  remote_write:
    - url: http://127.0.0.1:[[ var "port" . ]]/api/v1/write
Query it from Grafana with a Prometheus datasource pointed at http://<node-ip>:[[ var "port" . ]] .
