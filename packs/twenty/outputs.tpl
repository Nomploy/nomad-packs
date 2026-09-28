Twenty deployed as job "[[ var "job_name" . ]]" (all-in-one, host-networked on port [[ var "port" . ]]).

Web UI:    http://<node-ip>:[[ var "port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)

Bundled as prestart sidecars: PostgreSQL (port [[ var "db_port" . ]]) and Redis
(port [[ var "redis_port" . ]]); a background worker task runs alongside the
server. Database migrations run automatically on the server's first start.
Create the first workspace/account in the UI. Change db_password and app_secret
(keep app_secret stable) and set server_url before deploying anywhere real.
