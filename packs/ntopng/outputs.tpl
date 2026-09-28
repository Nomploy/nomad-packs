ntopng deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Web UI:    http://<node-ip>:[[ var "port" . ]]   (default login admin / admin — change it)
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)

ntopng captures traffic from the interface "[[ var "interface" . ]]" on the node
it runs on — set the `interface` var to your node's real NIC (e.g. eth0, ens18)
and pin the job (via constraints) to that node. The image bundles its own Redis.
Data persists in the data_volume.
