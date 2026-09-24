Bazarr deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Open:      http://<node-ip>:[[ var "port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)
Config:    Docker volume "[[ var "config_volume" . ]]" (/config) — back it up
Media:     Docker volume "[[ var "data_volume" . ]]" (/data) — same library as sonarr/radarr

Connect Bazarr to the sonarr and radarr packs (Settings, reachable on 127.0.0.1), pick your subtitle languages
and providers, and it fetches subtitles automatically. Use the SAME /data volume as those apps so paths line up.
Serves plain HTTP — front it with a reverse proxy for TLS.
