Kaneo deployed as job "[[ var "job_name" . ]]" (all-in-one, host-networked on port [[ var "port" . ]]).

Web UI:    http://<node-ip>:[[ var "port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)

Bundled: PostgreSQL (prestart sidecar, port [[ var "db_port" . ]]). The Kaneo image serves
both the API and the web UI and runs database migrations automatically on first start.
Create the first workspace/account in the UI.

CHANGE db_password and auth_secret before deploying anywhere real, and keep auth_secret
stable (rotating it signs everyone out). Set client_url to your public URL when serving
Kaneo behind a reverse proxy.
