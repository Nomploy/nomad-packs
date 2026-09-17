MariaDB deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Connect:   mysql://[[ var "db_user" . ]]:<db_password>@<node-ip>:[[ var "port" . ]]/[[ var "db_name" . ]]
Root:      user "root" / <root_password>
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)
Data:      Docker volume "[[ var "data_volume" . ]]" (persists across reschedules) — back it up
