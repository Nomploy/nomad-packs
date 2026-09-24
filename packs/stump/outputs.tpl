Stump deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Open:      http://<node-ip>:[[ var "port" . ]]
OPDS:      http://<node-ip>:[[ var "port" . ]]/opds/v1.2/catalog
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)
Config:    Docker volume "[[ var "config_volume" . ]]" (/config: DB, thumbnails) — back it up
Library:   Docker volume "[[ var "library_volume" . ]]" (/data) — your comics/manga/books

On first run, create the admin account, then add libraries pointing at folders under /data. Copy your files
into the "[[ var "library_volume" . ]]" volume (or swap the mount for a bind to your media). Use the web reader
or any OPDS-compatible app. Serves plain HTTP — front it with a reverse proxy for TLS.
