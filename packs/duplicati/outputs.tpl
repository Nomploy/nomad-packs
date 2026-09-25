Duplicati deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Open:      http://<node-ip>:[[ var "port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)
Config:    Docker volume "[[ var "config_volume" . ]]" (/config) — jobs + settings; back it up
Backup me: mount data at /source (swap the source volume for a bind); local targets go in /backups

In the web UI, set a UI password, then create a backup job: choose a destination (local /backups, or S3/B2/
WebDAV/SFTP/…), pick /source as the data, set a schedule and a strong backup passphrase. Keep the passphrase and
SETTINGS_ENCRYPTION_KEY safe — you need them to restore. Front the UI with a reverse proxy for TLS.
