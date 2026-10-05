Certimate deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Web UI:    http://<node-ip>:[[ var "port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)

Certimate stores its database and state in the certimate_data volume (PocketBase pb_data).
On first visit, create the admin account, then add your ACME account, DNS/hosting
provider credentials and certificate workflows. No external database is needed.

It holds provider API credentials, so keep it behind your VPN or a reverse proxy with
authentication and back up the certimate_data volume.
