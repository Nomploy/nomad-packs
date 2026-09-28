ArchiveBox deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Web UI:    http://<node-ip>:[[ var "port" . ]]
Login:     [[ var "admin_user" . ]] / (the admin_password you set)
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)

On first start ArchiveBox initialises the /data collection and creates the admin
account. Change admin_password and set csrf_trusted_origins to your public URL
before deploying anywhere real. Add URLs from the UI, the CLI, or by importing
bookmarks/RSS; snapshots persist in the data_volume.
