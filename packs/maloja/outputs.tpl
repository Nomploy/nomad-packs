Maloja deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Open:      http://<node-ip>:[[ var "port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)
Data:      Docker volume "[[ var "data_volume" . ]]" (/mljdata: scrobble DB, settings, API keys) — back it up

Log in with the password you set (MALOJA_FORCE_PASSWORD), then create an API key under Settings and
point your scrobbler at http://<node-ip>:[[ var "port" . ]] (many players support Maloja natively, or
via a Last.fm-compatible bridge). Serves plain HTTP — front it with a reverse proxy for TLS.
