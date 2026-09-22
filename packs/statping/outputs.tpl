Statping-ng deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Web UI:    http://<node-ip>:[[ var "port" . ]]
Login:     [[ var "admin_user" . ]] / (the admin_password you set)
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)

Add services to monitor from the dashboard. Config, the SQLite database, and assets live on the
[[ var "data_volume" . ]] volume (/app) — back it up and pin the job to that node with the
constraints variable.
