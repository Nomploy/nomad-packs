ezBookkeeping deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Web UI:    http://<node-ip>:[[ var "port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)

ezBookkeeping stores its SQLite database in the ezbookkeeping_data volume and uploaded
files in ezbookkeeping_storage — no external database is needed. Create the first account
in the UI.

CHANGE secret_key to a long random value before deploying anywhere real and keep it stable
(rotating it invalidates existing sessions).
