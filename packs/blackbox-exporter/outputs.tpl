Blackbox Exporter deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Endpoint:  http://<node-ip>:[[ var "port" . ]]  (probe: /probe?target=<url>&module=http_2xx)
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)

Have Prometheus (the monitoring pack) scrape targets through it — example prometheus.yml:
  - job_name: blackbox
    metrics_path: /probe
    params: { module: [http_2xx] }
    static_configs:
      - targets: ['https://example.com']
    relabel_configs:
      - source_labels: [__address__]
        target_label: __param_target
      - source_labels: [__param_target]
        target_label: instance
      - target_label: __address__
        replacement: 127.0.0.1:[[ var "port" . ]]
