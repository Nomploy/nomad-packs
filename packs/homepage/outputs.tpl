Homepage deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Open:      http://<node-ip>:[[ var "port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)
Config:    Docker volume "[[ var "data_volume" . ]]" (edit the YAML files there) — back it up

[[ if eq (var "allowed_hosts" .) "" ]]⚠ allowed_hosts is EMPTY. Recent Homepage blocks requests whose Host isn't allowed — if you
see a "host validation" error, redeploy with allowed_hosts set to "<node-ip>:[[ var "port" . ]]"
(or your domain). [[ else ]]Allowed hosts: [[ var "allowed_hosts" . ]][[ end ]]
Edit services.yaml / bookmarks.yaml / widgets.yaml / settings.yaml in the config volume.
