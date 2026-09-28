ArangoDB deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Web UI:    http://<node-ip>:[[ var "port" . ]]   (login: root / the root_password you set)
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)

Change root_password before deploying anywhere real. Database files and Foxx
apps persist in their volumes.
