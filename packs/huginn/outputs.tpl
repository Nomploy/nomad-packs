Huginn deployed as job "[[ var "job_name" . ]]" (all-in-one, host-networked on port [[ var "port" . ]]).

Web UI:    http://<node-ip>:[[ var "port" . ]]
Login:     [[ var "admin_user" . ]] / (the admin_password you set)
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)

MySQL is bundled inside the same container; its data persists in the data_volume.
First boot runs migrations and seeds the admin account, so give it a minute.
Change admin_password and app_secret_token before deploying anywhere real, and
set domain to the address you serve Huginn from.
