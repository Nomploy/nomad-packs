job "[[ var "job_name" . ]]" {
  namespace   = "[[ var "namespace" . ]]"
  datacenters = [[ var "datacenters" . | toStringList ]]
  type        = "batch"

  periodic {
    cron             = "[[ var "cron" . ]]"
    prohibit_overlap = true
    time_zone        = "[[ var "time_zone" . ]]"
  }

  [[- range $c := var "constraints" . ]]
  constraint {
    attribute = "[[ $c.attribute ]]"
    operator  = "[[ $c.operator ]]"
    value     = "[[ $c.value ]]"
  }
  [[- end ]]

  group "[[ var "job_name" . ]]" {
    count = 1

    # Host networking so a local S3 target (e.g. the seaweedfs pack on 127.0.0.1)
    # is reachable; a remote repository works over host networking too.
    network {
      mode = "host"
    }

    task "restic" {
      driver = "docker"

      config {
        image        = "[[ var "image" . ]]"
        network_mode = "host"

        # Init the repo on first run, snapshot the mounted volumes, then prune.
        entrypoint = ["/bin/sh", "-c"]
        args = [
          "set -e; restic snapshots >/dev/null 2>&1 || restic init; restic backup /data --host [[ var "job_name" . ]] --tag nomploy; restic forget --keep-daily [[ var "keep_daily" . ]] --keep-weekly [[ var "keep_weekly" . ]] --keep-monthly [[ var "keep_monthly" . ]] --prune",
        ]

        # Each named volume mounted read-only under /data/<name>.
        [[- range $v := var "volumes" . ]]
        mount {
          type     = "volume"
          source   = "[[ $v ]]"
          target   = "/data/[[ $v ]]"
          readonly = true
        }
        [[- end ]]
      }

      env {
        RESTIC_REPOSITORY = "[[ var "repository" . ]]"
        RESTIC_PASSWORD   = "[[ var "restic_password" . ]]"
        [[- if ne (var "access_key" .) "" ]]
        AWS_ACCESS_KEY_ID     = "[[ var "access_key" . ]]"
        AWS_SECRET_ACCESS_KEY = "[[ var "secret_key" . ]]"
        [[- end ]]
      }

      resources {
        cpu    = [[ (var "resources" .).cpu ]]
        memory = [[ (var "resources" .).memory ]]
      }
    }
  }
}
