Owncast deployed as job "[[ var "job_name" . ]]" (host-networked).

Web / chat:  http://<node-ip>:[[ var "port" . ]]
Admin:       http://<node-ip>:[[ var "port" . ]]/admin  (default login admin / abc123 — change it)
RTMP ingest: rtmp://<node-ip>:[[ var "rtmp_port" . ]]/live  (stream key set in the admin)
Discovery:   Nomad service "[[ var "job_name" . ]]" (provider=nomad)

Point OBS (or any RTMP broadcaster) at the RTMP URL with your stream key; viewers watch at the web
URL with live chat. Config, HLS segments, and logs live on the [[ var "data_volume" . ]] volume
(/app/data). Transcoding is CPU-heavy — raise resources.cpu for multiple qualities. Pin the job to
the node holding the volume with the constraints variable.
