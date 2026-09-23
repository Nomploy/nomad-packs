Mattermost deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Web UI:    http://<node-ip>:[[ var "port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)

Tasks: init (chown dirs) + postgres (prestart sidecar) + mattermost (app).

Create the first account (it becomes the System Admin) and your first team on first visit.
[[ if eq (var "site_url" .) "" ]]NOTE: set the site_url variable to this node's host/IP or your domain (MM_SERVICESETTINGS_SITEURL) —
some features (uploads, integrations, mobile) need a correct Site URL.
[[ else ]]Site URL: [[ var "site_url" . ]]
[[ end ]]
Messages live in PostgreSQL ([[ var "db_data_volume" . ]]); uploads on [[ var "data_volume" . ]].
Pin the job to the node holding the volumes with the constraints variable.
