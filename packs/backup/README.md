# backup

Scheduled volume backups with [restic](https://restic.net) — a **periodic Nomad batch
job** that snapshots the Docker named volumes you list to an S3-compatible repository
(pairs with the `seaweedfs` pack), encrypted and with automatic retention/pruning.

This is the safety net for the stateful packs (postgres, mariadb, gitea, vaultwarden, …).

## Usage

```sh
nomad-pack registry add nomploy github.com/Nomploy/nomad-packs
nomad-pack run backup --registry nomploy \
  --var 'volumes=["postgres_data","gitea_data"]' \
  --var 'repository=s3:http://<node-ip>:8333/backups' \
  --var 'restic_password=<a-strong-secret>' \
  --var 'access_key=<s3-key>' --var 'secret_key=<s3-secret>'
```

In nomploy: create a Compose service, type **Nomad Pack**, pack `backup`, set the variables,
then Deploy. Trigger a run immediately with `nomad job periodic force backup`.

## How it works

- Runs on the schedule in `cron` (default daily 03:00) as a `batch` job with
  `prohibit_overlap`.
- Mounts each volume in `volumes` **read-only** under `/data/<name>` and runs
  `restic backup /data`.
- On the first run it `restic init`s the repository; afterwards it appends snapshots and
  runs `restic forget --prune` per the retention policy.

## Key variables

| Variable | Default | Notes |
|---|---|---|
| `volumes` | `[]` | **Required.** Named volumes to back up, e.g. `["postgres_data"]`. |
| `repository` | `s3:http://127.0.0.1:8333/backups` | restic repo URL (seaweedfs/S3). The bucket must exist. |
| `restic_password` | `changeme` | **Change it and keep it safe — no password, no restore.** |
| `access_key` / `secret_key` | `""` | S3 credentials for the repository. |
| `cron` / `time_zone` | `0 3 * * *` / `UTC` | Schedule. |
| `keep_daily` / `keep_weekly` / `keep_monthly` | `7` / `4` / `6` | Retention. |
| `constraints` | `[]` | **Pin to the node holding the volumes** (they're node-local). |

## Notes

- **Placement matters.** Docker named volumes are node-local, so set `constraints` to the
  node where the source packs run — otherwise the volumes won't be there to back up.
- **Databases:** a read-only filesystem snapshot of a live DB volume is only crash-
  consistent. For a guaranteed-consistent backup, dump the database (`pg_dump`,
  `mariadb-dump`) into a volume and back that up, or quiesce the DB during the window.
- **Restore / inspect:** point `restic` at the same repository + password
  (`restic snapshots`, `restic restore <id> --target /restore`). Store the password
  somewhere safe and separate.
- The S3 bucket/target must exist before the first run (e.g. `aws --endpoint-url … s3 mb
  s3://backups`).
