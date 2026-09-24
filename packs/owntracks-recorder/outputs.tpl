OwnTracks Recorder deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Open:      http://<node-ip>:[[ var "port" . ]]  (map + recorder UI)
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)
Data:      Docker volume "[[ var "data_volume" . ]]" (/store) — your location history; back it up

Runs in HTTP mode (no MQTT broker). In the OwnTracks phone app, set Mode = HTTP and the URL to
http://<node-ip>:[[ var "port" . ]]/pub?u=<user>&d=<device>. The Recorder has NO built-in auth — it stores
sensitive location data, so keep it on an internal network or front it with an authenticating reverse proxy.
