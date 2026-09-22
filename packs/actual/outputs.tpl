Actual deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Open:      http://<node-ip>:[[ var "port" . ]]  (set a server password on first visit, then create a budget)
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)
Data:      Docker volume "[[ var "data_volume" . ]]" (budgets + sync DB) — back it up

Front with a reverse proxy for TLS (the browser app and mobile/desktop clients sync to this
server). The server password is set in the UI on first use.
