Donetick deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Open:      http://<node-ip>:[[ var "port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)
Data:      Docker volume "[[ var "data_volume" . ]]" (/donetick-data: SQLite DB) — back it up

Create your account on first visit, then add tasks/chores, set recurring schedules, and invite others to a
shared circle. Keep DT_JWT_SECRET stable and secret. Configure notifications (Telegram, webhooks) in the
settings or the /config file. Serves plain HTTP — front it with a reverse proxy for TLS.
