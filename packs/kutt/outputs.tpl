Kutt deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Web UI:    http://<node-ip>:[[ var "port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)

Register the first account to start shortening links. Set default_domain to the
public host that short links should use, and change jwt_secret before deploying
anywhere real. The SQLite database persists in the data_volume. Email
verification and Redis are disabled for a simple single-node setup; enable them
via the MAIL_*/REDIS_* env vars if needed.
