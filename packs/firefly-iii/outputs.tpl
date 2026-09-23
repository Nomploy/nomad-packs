Firefly III deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Web UI:    http://<node-ip>:[[ var "port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)

Tasks: init (chown upload) + mariadb (prestart sidecar) + firefly (app).

Register the first account on first visit (it becomes the owner). Migrations run automatically on
first boot (the app may take a moment before it's ready).

IMPORTANT: APP_KEY must be exactly 32 characters — change the default to a random value. The app's
Apache binds port 8080 (not changeable via env) — front it with a reverse proxy to serve elsewhere.
Financial data lives in MariaDB ([[ var "db_data_volume" . ]]); uploads on [[ var "upload_volume" . ]].
Pin the job to the node holding the volumes with the constraints variable.
