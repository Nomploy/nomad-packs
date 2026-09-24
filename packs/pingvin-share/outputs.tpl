Pingvin Share deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Open:      http://<node-ip>:[[ var "port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)
Data:      Docker volume "[[ var "data_volume" . ]]" (/opt/app/backend/data: SQLite DB + uploads) — back it up

On first run, open the UI to create the admin account, then set the App URL and limits under the admin
settings. Create a share to get a link with optional expiry, password, and download limit; enable reverse
shares to let others upload to you. Serves plain HTTP — front it with a reverse proxy for TLS.
