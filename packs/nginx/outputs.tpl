nginx deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Open:      http://<node-ip>:[[ var "port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)

To publish it on a domain, front it with Traefik (add a service tag) or put it
behind nomploy's ingress. Replace the page via the "index_html" variable.
