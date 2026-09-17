ClickHouse deployed as job "[[ var "job_name" . ]]" (host-networked).

HTTP:      http://<node-ip>:[[ var "http_port" . ]]   (play UI at /play; clients use this port)
Native:    <node-ip>:[[ var "tcp_port" . ]]   (clickhouse-client --host <node-ip> --port [[ var "tcp_port" . ]])
Login:     user "[[ var "db_user" . ]]" / <db_password>, database "[[ var "db_name" . ]]"
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad) on the HTTP port
Data:      Docker volume "[[ var "data_volume" . ]]" — back it up

Quick test:  curl "http://<node-ip>:[[ var "http_port" . ]]/?user=[[ var "db_user" . ]]&password=<pw>" --data-binary "SELECT version()"
