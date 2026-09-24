Beaver Habit Tracker deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Open:      http://<node-ip>:[[ var "port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)
Data:      Docker volume "[[ var "data_volume" . ]]" (/app/.user) — your habits + history; back it up

Register an account on first visit, then add habits and tap the day cells to check them off. Storage is
"[[ var "storage" . ]]". There's a REST API for automation (e.g. from your phone's shortcuts). Serves plain
HTTP — front it with a reverse proxy for TLS.
