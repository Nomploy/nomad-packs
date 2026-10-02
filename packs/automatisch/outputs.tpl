Automatisch deployed as job "[[ var "job_name" . ]]" (all-in-one, host-networked on port [[ var "port" . ]]).

Web UI:    http://<node-ip>:[[ var "port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)

Bundled as prestart sidecars: PostgreSQL (port [[ var "db_port" . ]]) and Redis
(port [[ var "redis_port" . ]]); a background worker task runs the automation queue
alongside the web task. Database migrations run automatically on the web task's first
start. Create the first account in the UI.

CHANGE db_password, encryption_key, webhook_secret_key and app_secret_key before
deploying anywhere real, and keep the three secret keys stable (rotating encryption_key
makes previously stored connection credentials unreadable). Set host and protocol to the
public hostname/scheme so generated webhook URLs are reachable.
