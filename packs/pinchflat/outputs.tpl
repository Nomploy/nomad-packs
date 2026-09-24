Pinchflat deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Open:      http://<node-ip>:[[ var "port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)
Config:    Docker volume "[[ var "config_volume" . ]]" (/config: SQLite DB) — back it up
Media:     Docker volume "[[ var "downloads_volume" . ]]" (/downloads)

Add a "source" (a channel or playlist) and Pinchflat downloads new videos automatically on a schedule via
yt-dlp, with optional podcast RSS feeds. Set basic_auth_username/password to require a login (it has none by
default). Only download content you're allowed to. Serves plain HTTP — front it with a reverse proxy for TLS.
