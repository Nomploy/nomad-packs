# jellystat

[Jellystat](https://github.com/CyferShepard/Jellystat) — a free, open-source **statistics dashboard for
Jellyfin**. Watch history, most-active users, library growth, playback and transcode stats, and scheduled
backups — the Jellyfin counterpart to Tautulli for Plex.

All-in-one host-networked Nomad job: the **Jellystat** app plus a **PostgreSQL** sidecar.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run jellystat --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `3000` | Web app port. The container listens on 3000. |
| `jwt_secret` | `change-me-…` | `JWT_SECRET` — signs auth tokens. **Change it** (`openssl rand -hex 32`). |
| `db_password` | `jellystat` | PostgreSQL password. |
| `db_port` | `5432` | Host port for the bundled PostgreSQL. |
| `db_data_volume` | `jellystat_db_data` | `/var/lib/postgresql/data` — collected statistics. |
| `image` | `cyfershepard/jellystat:latest` | App image. Pin a tag in production. |
| `resources` / `postgres_resources` | see `variables.hcl` | Per-task resources. |

On first run, create the admin account and connect Jellystat to your Jellyfin server (URL + API key). **Requires a
Jellyfin server to monitor** (pairs with the `jellyfin` pack). Keep `JWT_SECRET` stable. Serves plain HTTP — front
it with a reverse proxy for TLS. Pin the job to the node holding the volume with `constraints`.
