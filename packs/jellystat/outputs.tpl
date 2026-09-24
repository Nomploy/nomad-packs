Jellystat deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Open:      http://<node-ip>:[[ var "port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)
Database:  co-located PostgreSQL on port [[ var "db_port" . ]], volume "[[ var "db_data_volume" . ]]" — back it up

On first run, create the admin account and connect Jellystat to your Jellyfin server (URL + API key). It then
imports history and tracks stats. Requires a Jellyfin server to monitor. Keep JWT_SECRET stable. Serves plain HTTP
— front it with a reverse proxy for TLS.
