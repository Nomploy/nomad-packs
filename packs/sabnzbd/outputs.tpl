SABnzbd deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Open:      http://<node-ip>:[[ var "port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)
Config:    Docker volume "[[ var "config_volume" . ]]" (/config) — back it up
Downloads: Docker volume "[[ var "data_volume" . ]]" (/data)

Run the setup wizard, add your Usenet provider, and set the download folder under /data. Connect it as the
download client in the sonarr/radarr/lidarr packs, sharing the same /data volume for hardlinks. If you reach it by
hostname and see a "refused" page, add that host to "host_whitelist" in the config. Front it with a reverse proxy
for TLS.
