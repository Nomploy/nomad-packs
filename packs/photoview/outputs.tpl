Photoview deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Web UI:    http://<node-ip>:[[ var "port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)

Put your photos under the /photos volume (or mount an existing library there).
On first run, open the UI to create the initial user, then add a media path
pointing at /photos and let Photoview scan. The SQLite database and thumbnail
cache persist in the data_volume.
