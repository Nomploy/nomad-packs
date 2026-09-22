Postgres Exporter deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Metrics:   http://<node-ip>:[[ var "port" . ]]/metrics
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)

Scrape it from Prometheus (the monitoring pack):
  - job_name: postgres
    static_configs:
      - targets: ['127.0.0.1:[[ var "port" . ]]']

Point it at your database with the data_source_name variable. Prefer a read-only
monitoring role, e.g.:
  CREATE USER pg_exporter WITH PASSWORD '...';
  GRANT pg_monitor TO pg_exporter;
