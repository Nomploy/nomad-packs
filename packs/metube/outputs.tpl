MeTube deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Open:      http://<node-ip>:[[ var "port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)
Downloads: Docker volume "[[ var "downloads_volume" . ]]" (/downloads) — your files

Paste a video or playlist URL, pick format/quality, and it downloads to the volume via yt-dlp. Point your
media server (jellyfin/navidrome pack) at the same files. MeTube has no auth — keep it on an internal network
or front it with an authenticating reverse proxy, and only download content you're allowed to.
