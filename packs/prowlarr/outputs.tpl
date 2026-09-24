Prowlarr deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Open:      http://<node-ip>:[[ var "port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)
Config:    Docker volume "[[ var "config_volume" . ]]" (/config) — back it up

Add your indexers in Prowlarr, then connect your apps (Settings > Apps) so it syncs indexers to the sonarr /
radarr packs automatically. Co-located apps are reachable on 127.0.0.1. Serves plain HTTP — front it with a
reverse proxy for TLS. Only use indexers you're entitled to.
