changedetection.io deployed as job "[[ var "job_name" . ]]" (host-networked on port [[ var "port" . ]]).

Web UI:    http://<node-ip>:[[ var "port" . ]]
Discovery: Nomad service "[[ var "job_name" . ]]" (provider=nomad)

Add a URL to watch and set a check interval; you'll get visual diffs and notifications on
change. Set an app password under Settings for anything internet-reachable.

All config and history live on the [[ var "data_volume" . ]] volume (/datastore) — back it up and
pin the job to that node with the constraints variable.

For JavaScript-rendered pages, run a separate Playwright/Chrome container and point
PLAYWRIGHT_DRIVER_URL at it (not included here — plain HTTP fetching works out of the box).
