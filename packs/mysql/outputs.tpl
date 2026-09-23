MySQL deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Connect: mysql://[[ var "username" . ]]:<password>@<node-ip>:[[ var "port" . ]]/[[ var "database" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)

A database "[[ var "database" . ]]" and user "[[ var "username" . ]]" are created on first start;
root is also available. Data lives on the [[ var "data_volume" . ]] volume (/var/lib/mysql) — back it
up and pin the job to that node with the constraints variable. Change the default passwords.
