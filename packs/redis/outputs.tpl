Redis deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Connect:   redis://[[ if ne (var "password" .) "" ]]:<password>@[[ end ]]<node-ip>:[[ var "port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)
Data:      Docker volume "[[ var "data_volume" . ]]" (AOF persistence)
Auth:      [[ if ne (var "password" .) "" ]]requirepass set[[ else ]]OPEN — no password (only safe on a private network)[[ end ]]
