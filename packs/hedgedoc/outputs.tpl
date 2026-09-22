HedgeDoc deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Web UI:    http://<node-ip>:[[ var "port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)

Tasks: init (chown uploads) + postgres (prestart sidecar) + hedgedoc (app).

[[ if eq (var "domain" .) "" ]]NOTE: CMD_DOMAIN is unset (defaults to localhost). For remote access, real-time sync
and correct links, set the domain variable to this node's host/IP or your domain.
[[ else ]]Reachable at http://[[ var "domain" . ]]:[[ var "port" . ]] (CMD_DOMAIN=[[ var "domain" . ]], CMD_URL_ADDPORT=true).
[[ end ]]
Notes live in PostgreSQL on [[ var "db_data_volume" . ]]; uploads on [[ var "uploads_volume" . ]].
Anonymous access is [[ if var "allow_anonymous" . ]]ON[[ else ]]OFF[[ end ]] (allow_anonymous). Pin the job to the node
holding the volumes with the constraints variable.
