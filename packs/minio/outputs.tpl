MinIO deployed as job "[[ var "job_name" . ]]" (host-networked).

S3 API:    http://<node-ip>:[[ var "port" . ]]
Console:   http://<node-ip>:[[ var "console_port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)
Data:      Docker volume "[[ var "data_volume" . ]]" (/data) — all buckets/objects; back it up

Log in to the console with your MINIO_ROOT_USER / MINIO_ROOT_PASSWORD, then create buckets and
access keys. Point any S3 client at the API endpoint (region us-east-1). Serves plain HTTP — front
it with a reverse proxy for TLS. This is a single-node deployment; use it for backups, artifacts,
and app storage rather than as a highly-available cluster.
