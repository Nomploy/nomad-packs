Flame deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Web UI:    http://<node-ip>:[[ var "port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)

Viewing is public; to add/edit apps and bookmarks, open the settings and enter the password you set.
Data (SQLite + uploads) lives on the [[ var "data_volume" . ]] volume (/app/data) — back it up and
pin the job to that node with the constraints variable. Change the default password.
