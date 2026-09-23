Shiori deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Web UI:    http://<node-ip>:[[ var "port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)

Default login is shiori / gopher — change it immediately in the UI. Save bookmarks from the web UI,
the CLI, or the browser extension. Database and archives live on the [[ var "data_volume" . ]]
volume (/shiori) — back it up and pin the job to that node with the constraints variable.
