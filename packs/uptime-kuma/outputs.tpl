Uptime Kuma deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Open:      http://<node-ip>:[[ var "port" . ]]  (create the admin account on first visit)
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)
Data:      Docker volume "[[ var "data_volume" . ]]" (SQLite DB + config) — back it up

Add monitors from the UI (HTTP/TCP/ping/DNS/…) and wire up notifications.
