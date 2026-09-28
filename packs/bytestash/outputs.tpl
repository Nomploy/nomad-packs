ByteStash deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Web UI:    http://<node-ip>:[[ var "port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)

The first account you register becomes the owner. Change jwt_secret before
deploying anywhere real, and set allow_new_accounts=false afterwards to lock
sign-ups. Snippets and the SQLite database persist in the data_volume.
