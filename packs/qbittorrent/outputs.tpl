qBittorrent deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Open:      http://<node-ip>:[[ var "port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)
Config:    Docker volume "[[ var "config_volume" . ]]" (/config) — back it up
Downloads: Docker volume "[[ var "data_volume" . ]]" (/data)

Log in with admin and the TEMPORARY password printed in the task logs on first boot (`nomad alloc logs`), then
change it in Settings. Set the default save path under /data/downloads. Share the /data volume with the sonarr /
radarr packs so imports use fast hardlinks. Forward the torrent port for better peering. Use it only for content
you're entitled to; front the web UI with a reverse proxy for TLS.
