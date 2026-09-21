Jaeger deployed as job "[[ var "job_name" . ]]" (all-in-one, host-networked).

UI:        http://<node-ip>:[[ var "ui_port" . ]]
OTLP:      grpc <node-ip>:[[ var "otlp_grpc_port" . ]] · http <node-ip>:[[ var "otlp_http_port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad) on the UI port

Point your OpenTelemetry SDK/collector exporter at the OTLP endpoint, then view traces in
the UI. STORAGE IS IN-MEMORY — traces are lost on restart and bounded by RAM; use a real
backend (Cassandra/Elasticsearch/Badger) for anything you need to keep.
