linkding deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Open:      http://<node-ip>:[[ var "port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)
Data:      Docker volume "[[ var "data_volume" . ]]" (/etc/linkding/data: SQLite DB + snapshots) — back it up

Log in with LD_SUPERUSER_NAME / LD_SUPERUSER_PASSWORD (created on first boot). Grab the bookmarklet or
a browser extension from the Settings page to save links quickly. Serves plain HTTP — front it with a
reverse proxy for TLS.
