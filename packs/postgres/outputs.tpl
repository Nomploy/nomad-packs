PostgreSQL deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Connect:   postgres://[[ var "db_user" . ]]:<password>@<node-ip>:[[ var "port" . ]]/[[ var "db_name" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)
Data:      Docker volume "[[ var "data_volume" . ]]" (persists across restarts/reschedules)

Note: the password is baked into the job env — rotate it, and prefer a Nomad
variable or Vault over the default for anything real.
