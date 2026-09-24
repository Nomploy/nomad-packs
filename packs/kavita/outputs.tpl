Kavita deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Open:      http://<node-ip>:[[ var "port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)
Config:    Docker volume "[[ var "config_volume" . ]]" (/kavita/config: DB, covers, backups) — back it up
Library:   Docker volume "[[ var "library_volume" . ]]" (/data) — your manga/comics/books

On first run open the UI to create the admin account, then add libraries pointing at folders under
/data. To load existing files, copy them into the "[[ var "library_volume" . ]]" volume (or swap the
volume mount for a bind to your media directory). Serves plain HTTP — front it with a reverse proxy
for TLS.
