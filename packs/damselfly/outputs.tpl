Damselfly deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Web UI:    http://<node-ip>:[[ var "port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)

Put your photos under the /pictures volume (or mount your existing library
there); Damselfly scans the whole tree, generates thumbnails into /thumbs
and stores its database in /config.
