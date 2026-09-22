Wiki.js deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Web UI:    http://<node-ip>:[[ var "port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)

Tasks: postgres (prestart sidecar) + wikijs (app).

On first visit, complete the setup wizard to create the administrator account. All wiki content
lives in PostgreSQL on the [[ var "db_data_volume" . ]] volume (/var/lib/postgresql/data) — back
it up and pin the job to that node with the constraints variable.
