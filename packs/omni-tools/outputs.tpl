OmniTools deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Web UI:    http://<node-ip>:[[ var "port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)

OmniTools is a stateless static SPA — every tool runs in the browser, so no data leaves
the client and there is nothing to back up. nginx is reconfigured to listen on the chosen
host port (instead of 80) so it doesn't collide with a reverse proxy. Scale it freely by
raising count.
