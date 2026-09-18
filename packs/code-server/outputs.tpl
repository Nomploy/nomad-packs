code-server deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Open:      http://<node-ip>:[[ var "port" . ]]  (log in with your password)
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)
Data:      Docker volume "[[ var "data_volume" . ]]" (config, extensions, your files) — back it up

Serves plain HTTP — front it with a reverse proxy for TLS. Change the default password.
