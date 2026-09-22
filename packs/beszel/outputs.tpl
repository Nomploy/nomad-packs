Beszel hub deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Web UI:    http://<node-ip>:[[ var "port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)

Create the admin account on first visit. To monitor a machine, click "Add system" in the UI —
it gives you the beszel-agent install command plus the TOKEN and public KEY to use. Run the
agent (henrygd/beszel-agent) on each host you want to track (not included in this pack).

The hub's SQLite database and config live on the [[ var "data_volume" . ]] volume
(/beszel_data) — back it up and pin the job to that node with the constraints variable.
