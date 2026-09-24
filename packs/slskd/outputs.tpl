slskd deployed as job "[[ var "job_name" . ]]" (host-networked).

Web UI:    http://<node-ip>:[[ var "web_port" . ]]
Soulseek:  listening on port [[ var "listen_port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)
Data:      Docker volume "[[ var "data_volume" . ]]" (/app: config, db, downloads, shares) — back it up

Log in to the web UI (default credentials are slskd / slskd — CHANGE them under Options / the config file).
Your Soulseek account is set via SLSKD_SLSK_USERNAME/PASSWORD. Forward the listen port for better peering.
Serves plain HTTP — front it with a reverse proxy for TLS, and only share content you're allowed to.
