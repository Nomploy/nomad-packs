Gokapi deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Web UI:    http://<node-ip>:[[ var "port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)

On first run, open http://<node-ip>:[[ var "port" . ]]/setup and follow the setup wizard
to create the admin account and choose the encryption level. Gokapi stores uploads and
its SQLite database in the gokapi_data volume and its config in gokapi_config — no
external database is needed.

Keep it behind your VPN or a reverse proxy with authentication if you don't want the
upload UI publicly reachable.
