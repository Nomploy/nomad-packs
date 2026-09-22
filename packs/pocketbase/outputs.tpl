PocketBase deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Admin UI:  http://<node-ip>:[[ var "port" . ]]/_/   (create the superuser on first visit)
API:       http://<node-ip>:[[ var "port" . ]]/api/
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)
Data:      Docker volume "[[ var "data_volume" . ]]" (SQLite DB + files) — back it up

Front with a reverse proxy for TLS. Note: this uses the community PocketBase image (there is
no official one).
