Grist deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Web UI:    http://<node-ip>:[[ var "port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)

Documents and SQLite metadata live on the [[ var "data_volume" . ]] volume (/persist) — back it
up and pin the job to that node with the constraints variable.

Set a long random session_secret for production.[[ if eq (var "default_email" .) "" ]] Optionally set default_email to make an
account the initial owner/admin.[[ end ]] For a reverse proxy / custom hostname, set app_home_url
(APP_HOME_URL) to the public base URL.
