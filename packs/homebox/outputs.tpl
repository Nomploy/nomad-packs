HomeBox deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Web UI:    http://<node-ip>:[[ var "port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)

Register the first account (registration is [[ if var "allow_registration" . ]]ON[[ else ]]OFF[[ end ]] via allow_registration).
Database and uploads live on the [[ var "data_volume" . ]] volume (/data) — back it up and pin the
job to that node with the constraints variable.
