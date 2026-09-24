Backrest deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Open:      http://<node-ip>:[[ var "port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)
Config:    Docker volume "[[ var "config_volume" . ]]" (/config) · Data: "[[ var "data_volume" . ]]" (/data)
Backup me: mount your real data at /userdata (swap the sources volume for a bind mount)

On first run, set an instance ID and admin password, then add a restic repository (local /data, S3/R2, SFTP,
rclone, …) and a backup plan pointing at /userdata. Pairs with the "minio" or "rest-server" packs as a restic
target. Keep the config/data volumes safe — they hold your repo passwords. Front it with a reverse proxy for TLS.
