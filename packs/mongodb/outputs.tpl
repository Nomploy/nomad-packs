MongoDB deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Connect:   mongodb://[[ var "root_username" . ]]:<password>@<node-ip>:[[ var "port" . ]]/?authSource=admin
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)

Authentication is enabled with the root account you configured. Change
root_password before deploying anywhere real. Data persists in the data_volume
at /data/db.
