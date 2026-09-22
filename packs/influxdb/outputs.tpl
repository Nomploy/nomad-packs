InfluxDB deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

UI/API:    http://<node-ip>:[[ var "port" . ]]  (login [[ var "admin_user" . ]] / <admin_password>)
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)
Data:      Docker volume "[[ var "data_volume" . ]]" — back it up
Org/Bucket: [[ var "org" . ]] / [[ var "bucket" . ]]   ·  write with the admin token

Write a point:
  curl -XPOST "http://<node-ip>:[[ var "port" . ]]/api/v2/write?org=[[ var "org" . ]]&bucket=[[ var "bucket" . ]]" \
    -H "Authorization: Token <admin_token>" --data-binary "temp value=21.5"
Change the admin password and token; front with a reverse proxy for TLS.
