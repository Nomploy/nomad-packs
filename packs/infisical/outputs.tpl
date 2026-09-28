Infisical deployed as job "[[ var "job_name" . ]]" (all-in-one, host-networked on port [[ var "port" . ]]).

Web UI:    http://<node-ip>:[[ var "port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)

Bundled as prestart sidecars: PostgreSQL (port [[ var "db_port" . ]]) and Redis
(port [[ var "redis_port" . ]]). Database migrations run automatically on start.
Create the first admin account in the UI. Change db_password, encryption_key,
auth_secret and site_url before deploying anywhere real — encryption_key and
auth_secret must stay stable or existing secrets become unreadable.
