Tautulli deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Open:      http://<node-ip>:[[ var "port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)
Config:    Docker volume "[[ var "config_volume" . ]]" (/config: SQLite DB) — back it up

On first run, connect Tautulli to your Plex Media Server (URL + token) and it starts recording watch history and
stats. Requires a Plex server to monitor. Serves plain HTTP — front it with a reverse proxy for TLS.
