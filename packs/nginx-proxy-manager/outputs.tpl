Nginx Proxy Manager deployed as job "[[ var "job_name" . ]]" (host-networked).

Admin UI:   http://<node-ip>:[[ var "admin_port" . ]]
Proxied:    HTTP :[[ var "http_port" . ]] / HTTPS :[[ var "https_port" . ]]
Discovery:  Nomad service "[[ var "job_name" . ]]" (provider=nomad)

Log in with the default credentials, then change them immediately:
  email:    admin@example.com
  password: changeme

Add proxy hosts in the UI and request Let's Encrypt certificates (the domain's DNS must point
here and ports [[ var "http_port" . ]]/[[ var "https_port" . ]] must be reachable from the
internet). Config + SQLite live on [[ var "data_volume" . ]]; certificates on
[[ var "letsencrypt_volume" . ]]. Pin the job to that node with the constraints variable.
