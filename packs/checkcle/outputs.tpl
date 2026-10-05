CheckCle deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Web UI:    http://<node-ip>:[[ var "port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)

CheckCle stores its database and state in the checkcle_data volume (PocketBase pb_data).
Create the admin account on first visit, then add uptime / SSL / DNS monitors, alert
channels and status pages. No external database is needed.
