Feishin deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Web UI:    http://<node-ip>:[[ var "port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)

Feishin is a music player front-end — point it at your own Jellyfin, Navidrome or any
Subsonic-compatible server (set server_type + server_url, or add the server in the UI on
first visit). Settings are stored in the browser, so the container is stateless; scale it
freely by raising count. It needs no database and no volumes.
