Filestash deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Open:      http://<node-ip>:[[ var "port" . ]]
Admin:     http://<node-ip>:[[ var "port" . ]]/admin
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)
Config:    Docker volume "[[ var "data_volume" . ]]" (/app/data/state) — admin config + state; back it up

On first run, open /admin to set the admin password, then configure storage backends (S3, SFTP, FTP,
WebDAV, Git, local, …). Set APPLICATION_URL to your real domain so share links are correct. Serves plain
HTTP — front it with a reverse proxy for TLS.
