# beaverhabits

[Beaver Habit Tracker](https://github.com/daya0576/beaverhabits) — a minimal, self-hosted habit tracker
"without goals." Add habits, tap to check them off each day, and watch your **streaks and heatmaps** build
up. Clean UI, mobile-friendly, and a small REST API for automation.

Single host-networked Nomad service using **SQLite** with a persistent data volume.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run beaverhabits --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `8080` | Web UI port. The container listens on 8080. |
| `storage` | `DATABASE` | `HABITS_STORAGE`: `DATABASE` (single SQLite db) or `USER_DISK` (JSON file per user). |
| `data_volume` | `beaverhabits_data` | `/app/.user` — the database or per-user files. |
| `image` | `daya0576/beaverhabits:latest` | Container image. Pin a tag in production. |
| `resources` | `{ cpu = 300, memory = 256 }` | Task resources. |

Register an account on first visit, then add habits and tap the day cells. A REST API is available for
automation (e.g. phone shortcuts / cron). Serves plain HTTP — front it with a reverse proxy for TLS. Pin the
job to the node holding the volume with `constraints`.
