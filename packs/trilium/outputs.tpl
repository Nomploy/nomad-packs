Trilium deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Web UI:    http://<node-ip>:[[ var "port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)

Set a password on first visit (it protects the whole instance). Data (document.db, config,
attachments) lives on the [[ var "data_volume" . ]] volume (/home/node/trilium-data) — back it
up and pin the job to that node with the constraints variable.

Sync a desktop client to this server from the desktop app's sync settings.
