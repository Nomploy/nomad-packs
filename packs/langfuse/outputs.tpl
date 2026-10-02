Langfuse deployed as job "[[ var "job_name" . ]]" (all-in-one, host-networked on port [[ var "port" . ]]).

Web UI:    http://<node-ip>:[[ var "port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)

Bundled as prestart sidecars: PostgreSQL (port [[ var "db_port" . ]]), ClickHouse
(HTTP [[ var "clickhouse_http_port" . ]] / native [[ var "clickhouse_native_port" . ]]),
Redis (port [[ var "redis_port" . ]]) and MinIO (S3 [[ var "minio_port" . ]] /
console [[ var "minio_console_port" . ]]); a background worker runs alongside the web
task. Database and ClickHouse migrations run automatically on first start.

This is a heavy stack — schedule it on a node with ~8 GB free RAM. Create the first
user/organization in the UI. CHANGE nextauth_secret, salt, encryption_key (64 hex
chars), db_password, clickhouse_password, redis_password and minio_root_password, and
keep the secret/salt/encryption_key stable. Set nextauth_url before deploying anywhere
real; set s3_public_endpoint to a browser-reachable URL if you use media uploads.
