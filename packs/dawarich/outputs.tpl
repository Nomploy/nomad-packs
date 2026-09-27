Dawarich deployed as job "[[ var "job_name" . ]]" (all-in-one, host-networked).

Web UI:    http://<node-ip>:[[ var "port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)

Bundled in the same group: PostGIS (port [[ var "db_port" . ]]), Redis
(port [[ var "redis_port" . ]]) and a Sidekiq worker for background jobs.

First run: register the first account in the UI, then create an API key under
your account to send location data from the mobile apps (Overland / GPSLogger)
or to import Google Takeout / other history. Change db_password and
secret_key_base before deploying anywhere real.
