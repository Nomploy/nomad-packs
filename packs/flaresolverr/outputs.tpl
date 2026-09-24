FlareSolverr deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

API:       http://<node-ip>:[[ var "port" . ]]/v1
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)

Stateless — no volumes. In Prowlarr/Jackett/Bazarr, add FlareSolverr as an indexer proxy with the URL
http://127.0.0.1:[[ var "port" . ]] (co-located) so requests to Cloudflare-protected sites get solved. Runs a
headless browser, so it uses noticeable CPU/RAM while solving. Keep it on an internal network.
