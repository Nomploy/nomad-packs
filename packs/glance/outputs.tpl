Glance deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Open:      http://<node-ip>:[[ var "port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)

Stateless — the dashboard is defined by the `pages` variable (rendered into glance.yml). Edit
`pages` to add widgets (RSS, weather, markets, monitor, docker, custom API, …). See the Glance
docs for the full widget set.
