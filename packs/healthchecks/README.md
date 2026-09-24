# healthchecks

[Healthchecks](https://healthchecks.io) — a self-hosted monitor for cron jobs and background tasks (a
"dead man's switch"). Each job pings a unique URL when it finishes; if a ping is late or never arrives,
Healthchecks alerts you. Great for backups, scheduled scripts, and anything that should run on time.

Single host-networked Nomad service using **SQLite** with a persistent data volume.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run healthchecks --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `8000` | Web UI port. The container listens on 8000. |
| `site_root` | `""` → `http://localhost:<port>` | `SITE_ROOT` — set to your real domain; ping URLs use it. |
| `secret_key` | `change-me-…` | `SECRET_KEY` — **change it** (`openssl rand -hex 32`). |
| `superuser_email` | `admin@nomploy.local` | Initial admin (`SUPERUSER_EMAIL`). |
| `superuser_password` | `change-me-please` | Initial admin password (`SUPERUSER_PASSWORD`). **Change it.** |
| `data_volume` | `healthchecks_data` | `/data` — the SQLite database. |
| `image` | `healthchecks/healthchecks:latest` | Container image. Pin a tag in production. |
| `resources` | `{ cpu = 300, memory = 256 }` | Task resources. |

The admin account is created from the `SUPERUSER_*` env on first boot. Create a check, copy its ping
URL, and `curl` it from your job on success. Set `SITE_ROOT` so the URLs shown are correct. Add email or
webhook integrations for alerts (e.g. point them at the `ntfy`, `gotify`, or `apprise` packs). Serves
plain HTTP — front it with a reverse proxy for TLS. Pin the job to the node holding the volume with
`constraints`.
