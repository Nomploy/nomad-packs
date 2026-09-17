Grafana deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Open:      [[ if ne (var "root_url" .) "" ]][[ var "root_url" . ]][[ else ]]http://<node-ip>:[[ var "port" . ]][[ end ]]
Login:     [[ var "admin_user" . ]] / <admin_password>  (change it on first login)
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)
Data:      Docker volume "[[ var "data_volume" . ]]" (SQLite DB + plugins persist)
