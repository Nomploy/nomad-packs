Papra deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Web UI:    http://<node-ip>:[[ var "port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)

Papra stores its SQLite database and your documents in the papra_data volume
(/app/app-data) — no external database is needed. Create the first account in the UI.

CHANGE auth_secret before deploying anywhere real (it is required and signs sessions) and
keep it stable. Set app_base_url to your public URL when serving Papra behind a proxy.
