MicroBin deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Web UI:    http://<node-ip>:[[ var "port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)
Admin:     [[ var "admin_username" . ]] / (the admin_password you set)

Share text or files with optional expiry, encryption, and QR codes. Set public_url to the URL you
access it on so generated links/QR codes are correct. Data lives on the [[ var "data_volume" . ]]
volume (/app/microbin_data) — back it up and pin the job to that node with the constraints variable.
