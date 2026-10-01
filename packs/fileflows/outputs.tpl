FileFlows deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Web UI:    http://<node-ip>:[[ var "port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)

Open the UI, accept the EULA (required before any processing runs), then build a
flow and point a library at /media. Put the files you want processed under the
media volume. Config, the database and logs persist in the data_volume; /temp is
scratch space for in-progress transcodes.
