Kimai deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Web UI:    http://<node-ip>:[[ var "port" . ]]
Login:     [[ var "admin_email" . ]] / (the admin_password you set)
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)

Tasks: init (chown data) + mariadb (prestart sidecar) + kimai (app). First boot runs migrations and
creates the super-admin (it can take a moment).

IMPORTANT: add the host/IP or domain you use to the trusted_hosts variable, or Kimai will reject the
request. Data lives in MariaDB ([[ var "db_data_volume" . ]]); uploads/invoices on
[[ var "data_volume" . ]]. Pin the job to the node holding the volumes with the constraints variable.
