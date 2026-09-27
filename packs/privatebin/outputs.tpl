PrivateBin deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Web UI:    http://<node-ip>:[[ var "port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)

PrivateBin works out of the box with file-based storage in /srv/data. To
customise (expiry options, size limits, discussions, templates), mount your own
conf.php at /srv/cfg/conf.php. Everything is encrypted in the browser, so the
server never sees your paste contents.
