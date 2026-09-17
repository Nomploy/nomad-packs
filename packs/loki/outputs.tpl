Loki deployed as job "[[ var "job_name" . ]]" (host-networked, single alloc).

Loki API:  http://<node-ip>:[[ var "loki_port" . ]]   (push + query)
Shipper:   [[ if var "enable_alloy" . ]]Alloy tailing this node's Docker containers → Loki (UI http://<node-ip>:[[ var "alloy_port" . ]])[[ else ]]disabled — push logs from your own agents to the Loki API[[ end ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad) on the Loki port
Data:      Docker volume "[[ var "loki_data_volume" . ]]" (chunks + index) — retention [[ var "retention" . ]]

Add to Grafana:  Connections → Data sources → Loki, URL http://127.0.0.1:[[ var "loki_port" . ]]
                 (or the node IP). Then in Explore try:  {job="docker"}
