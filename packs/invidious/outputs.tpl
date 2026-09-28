Invidious deployed as job "[[ var "job_name" . ]]" (all-in-one, host-networked on port [[ var "port" . ]]).

Web UI:    http://<node-ip>:[[ var "port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)

PostgreSQL is bundled as a prestart sidecar (port [[ var "db_port" . ]]) and the
schema is created automatically (check_tables). Change db_password and hmac_key
before deploying anywhere real. Note: YouTube periodically blocks server IPs, so
a public Invidious instance may need extra config (po_token / proxies) over time.
