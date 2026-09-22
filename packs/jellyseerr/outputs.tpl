Jellyseerr deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Web UI:    http://<node-ip>:[[ var "port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)

On first visit, sign in with your Jellyfin/Plex account and connect your media server plus
Sonarr/Radarr. Config and the SQLite database live on the [[ var "data_volume" . ]] volume
(/app/config) — pin the job to that node with the constraints variable. Pairs with the jellyfin pack.
