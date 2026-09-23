# cefiro

[Cefiro](https://cefiro.spertulo.sk) — a self-hosted **social recipe platform and hands-on cooking
helper** for home cooks. Discover recipes ("cook with what you have"), plan the week, generate a
shopping list from the meal plan, and get guided step-by-step in cook mode (with per-step timers).
An [AGPL-3.0](https://github.com/pipozzz/cefiro/blob/main/LICENSE) fork of
[Norish](https://github.com/norish-recipes/Norish).

All-in-one host-networked Nomad job: the **Cefiro app** + **PostgreSQL 17** + **Redis** + **Obscura**
(the page-renderer used for URL recipe imports), with persistent volumes.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run cefiro --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `3021` | Web app port (`PORT`). |
| `base_url` | `""` → `http://localhost:<port>` | `AUTH_URL` — set to your real domain. |
| `master_key` | `change-me-…` | `MASTER_KEY` — **change it and keep it stable** (`openssl rand -base64 32`); it derives all encryption keys. |
| `password_auth_enabled` | `true` | Allow email/password auth so you can create the first admin. |
| `db_password` | `cefiro` | PostgreSQL password. |
| `db_port` / `redis_port` / `obscura_port` | `5432` / `6379` / `9222` | Host ports for the bundled services. |
| `uploads_volume` | `cefiro_uploads` | `/app/uploads` — uploaded images/videos. |
| `db_data_volume` | `cefiro_db_data` | `/var/lib/postgresql/data` — all recipes. |
| `redis_data_volume` | `cefiro_redis_data` | `/data`. |
| `image` | `ghcr.io/pipozzz/cefiro:latest` | App image. Pin a version/sha in production. |
| `resources` / `*_resources` | see `variables.hcl` | Per-task resources. |

The app runs its database migrations on boot. Keep **`MASTER_KEY` stable** — changing it invalidates
previously encrypted data. To store media in S3/R2 instead of the uploads volume, add
`STORAGE_DRIVER=s3` plus the `S3_*` env vars to the `cefiro` task. Pin the job to the node holding the
volumes with `constraints`, and front it with a reverse proxy for TLS.
