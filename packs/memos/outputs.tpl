Memos deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Web UI:    http://<node-ip>:[[ var "port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)

The first account you create becomes the host/admin. Database and uploads live on the
[[ var "data_volume" . ]] volume (/var/opt/memos) — back it up and pin the job to that node with
the constraints variable.
