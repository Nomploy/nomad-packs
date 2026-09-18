Backup deployed as periodic job "[[ var "job_name" . ]]" (restic, cron "[[ var "cron" . ]]" [[ var "time_zone" . ]]).

Repository: [[ var "repository" . ]]
Volumes:    [[ range $i, $v := var "volumes" . ]][[ if $i ]], [[ end ]][[ $v ]][[ end ]]
Retention:  keep [[ var "keep_daily" . ]] daily / [[ var "keep_weekly" . ]] weekly / [[ var "keep_monthly" . ]] monthly

Run it now:      nomad job periodic force [[ var "job_name" . ]]
List snapshots:  run restic against the same repo/password, e.g.
  docker run --rm -e RESTIC_REPOSITORY=[[ var "repository" . ]] -e RESTIC_PASSWORD=… \
    -e AWS_ACCESS_KEY_ID=… -e AWS_SECRET_ACCESS_KEY=… [[ var "image" . ]] snapshots

Pin this job (constraints) to the node holding the volumes — named volumes are node-local.
The S3 bucket/target must exist first; keep RESTIC_PASSWORD safe (no password = no restore).
