VictoriaLogs deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

HTTP API:  http://<node-ip>:[[ var "port" . ]]   (UI at /select/vmui)
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)
Data:      Docker volume "[[ var "data_volume" . ]]" (retention [[ var "retention" . ]]) — back it up

Ship logs to it via its ingestion APIs (Loki, Elasticsearch/Bulk, OpenTelemetry, or a log
shipper like Grafana Alloy/Fluent Bit), then query with LogsQL in the built-in UI.
