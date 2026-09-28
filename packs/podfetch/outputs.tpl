PodFetch deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Web UI:    http://<node-ip>:[[ var "port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)

Add podcasts by RSS URL or search from the UI; PodFetch downloads new episodes on
the polling_interval. Set server_url to your public address so generated feeds
link correctly. Episodes persist in the podcasts volume and metadata in the SQLite
database volume. Enable auth with BASIC_AUTH/OIDC env vars if you expose it.
