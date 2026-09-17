Monitoring stack deployed as job "[[ var "job_name" . ]]" (host-networked, single alloc).

Grafana:    [[ if ne (var "grafana_root_url" .) "" ]][[ var "grafana_root_url" . ]][[ else ]]http://<node-ip>:[[ var "grafana_port" . ]][[ end ]]
            login [[ var "grafana_admin_user" . ]] / <admin_password> — Prometheus datasource is pre-wired.
Prometheus: http://<node-ip>:[[ var "prometheus_port" . ]]  (Status → Targets to confirm scrapes are UP)
Exporters:  node-exporter :[[ var "node_exporter_port" . ]][[ if var "enable_cadvisor" . ]] · cAdvisor :[[ var "cadvisor_port" . ]] (per-container metrics)[[ else ]] (cAdvisor disabled)[[ end ]]
Discovery:  Nomad services "[[ var "job_name" . ]]-grafana" and "[[ var "job_name" . ]]-prometheus" (provider=nomad)
Data:       volumes "[[ var "prometheus_data_volume" . ]]" (TSDB) + "[[ var "grafana_data_volume" . ]]" (Grafana)

Note: metrics are for the single node this alloc runs on. Pin it with `constraints`.
Import a dashboard in Grafana to get started — e.g. 1860 (Node Exporter Full),
14282 (cAdvisor).
