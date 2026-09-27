# dawarich

[Dawarich](https://dawarich.app) is a self-hosted location-history tracker — an
open alternative to **Google Maps Timeline**. It ingests location points from
phone apps (Overland, GPSLogger, OwnTracks) or imports from Google Takeout,
OwnTracks, GPX and Immich, then shows your history on interactive maps with
stats, visited places, trips and heatmaps. Your movement data stays on your own
server.

This pack deploys Dawarich **all-in-one** as a single host-networked Nomad job:

- **PostGIS** (PostgreSQL + spatial) — bundled as a prestart sidecar
- **Redis** — bundled as a prestart sidecar (Sidekiq queue backend)
- **web** — the Rails/Puma web UI
- **sidekiq** — background worker for imports and processing

All four share one allocation and talk over `127.0.0.1`.

## Deploy

```bash
nomad-pack run dawarich --registry=nomploy \
  --var db_password=$(openssl rand -hex 16) \
  --var secret_key_base=$(openssl rand -hex 64)
```

Open `http://<node-ip>:3000` and register the first account.

## Configuration

| Variable          | Default                        | Description                                     |
| ----------------- | ------------------------------ | ----------------------------------------------- |
| `image`           | `freikin/dawarich:latest`      | App image (web + Sidekiq).                        |
| `postgres_image`  | `postgis/postgis:17-3.5-alpine`| PostGIS image (use `imresamu/postgis` on ARM).   |
| `redis_image`     | `redis:7.4-alpine`             | Redis image.                                      |
| `port`            | `3000`                         | Host port for the web UI.                         |
| `db_port`         | `5432`                         | Host port for PostGIS.                            |
| `redis_port`      | `6379`                         | Host port for Redis.                              |
| `db_password`     | `dawarich_change_me`           | PostGIS password — **change this**.               |
| `secret_key_base` | placeholder                    | Rails session secret — **change this**.           |
| `time_zone`       | `UTC`                          | Application timezone.                              |
| `resources`       | 1000 MHz / 2048 MB             | Web (Puma) resources.                             |
| `sidekiq_resources`| 1000 MHz / 2048 MB            | Sidekiq worker resources.                         |

Data persists across separate volumes for PostGIS, Redis, public assets,
watched imports and storage.
