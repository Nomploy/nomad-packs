Gotify deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Open:      http://<node-ip>:[[ var "port" . ]]  (login [[ var "admin_user" . ]] / <admin_password>, change it)
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)
Data:      Docker volume "[[ var "data_volume" . ]]" (SQLite DB + uploads) — back it up

Create an "application" in the UI to get a token, then push:
  curl "http://<node-ip>:[[ var "port" . ]]/message?token=<app-token>" -F "title=Hi" -F "message=It works"
Subscribe with the Gotify web UI or Android app. Front with a reverse proxy for TLS.
