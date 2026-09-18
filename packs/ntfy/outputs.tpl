ntfy deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Web/API:   [[ if ne (var "base_url" .) "" ]][[ var "base_url" . ]][[ else ]]http://<node-ip>:[[ var "port" . ]][[ end ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)
Data:      Docker volume "[[ var "data_volume" . ]]" (cache.db, auth.db, attachments)

Publish a notification:
  curl -d "Backup finished" [[ if ne (var "base_url" .) "" ]][[ var "base_url" . ]][[ else ]]http://<node-ip>:[[ var "port" . ]][[ end ]]/mytopic

Subscribe in the web app or the ntfy mobile app to the same topic. Set base_url and front
with a reverse proxy (TLS) for use with the mobile apps.
