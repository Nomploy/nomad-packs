Sonarr deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Open:      http://<node-ip>:[[ var "port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)
Config:    Docker volume "[[ var "config_volume" . ]]" (/config) — back it up
Media:     Docker volume "[[ var "data_volume" . ]]" (/data) — TV library + downloads

Add indexers (or connect the prowlarr pack), a download client (the qbittorrent pack), and your root folder under
/data/tv. Keep Sonarr, the download client, and your media server on the SAME /data volume so imports use fast
hardlinks/atomic moves. Serves plain HTTP — front it with a reverse proxy for TLS. Grab content you're entitled to.
