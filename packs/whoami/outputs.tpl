whoami deployed as job "[[ var "job_name" . ]]" ([[ var "count" . ]] instance(s), host-networked on port [[ var "port" . ]]).

Try it:    curl http://<node-ip>:[[ var "port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)

Echoes the request (hostname, client IP, headers). With count > 1 the "Hostname" line
changes between requests — handy for confirming load balancing / routing.
