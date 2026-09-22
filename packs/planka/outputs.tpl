Planka deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Web UI:    http://<node-ip>:[[ var "port" . ]]
Login:     [[ var "admin_username" . ]] / (the admin_password you set)  ([[ var "admin_email" . ]])
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)

Tasks: postgres (prestart sidecar) + planka (app).

[[ if eq (var "base_url" .) "" ]]NOTE: BASE_URL defaults to http://localhost:[[ var "port" . ]] — set the base_url variable to this
node's host/IP or your domain so links and websockets work for remote clients.
[[ else ]]Reachable at [[ var "base_url" . ]] (BASE_URL).
[[ end ]]
Volumes: boards live in PostgreSQL ([[ var "db_data_volume" . ]]); uploads on the avatars /
backgrounds / attachments volumes. Pin the job to the node holding them with the constraints
variable.

DEFAULT_ADMIN_* is re-applied on every boot — after first login, clear the admin_password
variable (redeploy) so password changes made in the UI stick.
