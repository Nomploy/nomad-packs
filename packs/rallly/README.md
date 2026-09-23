# rallly

[Rallly](https://rallly.co) — a self-hosted scheduling tool for finding the best time to meet.
Create a poll with candidate dates/times, share a link, collect everyone's availability, and lock
in the winning slot. A privacy-friendly Doodle alternative.

All-in-one host-networked Nomad job: a **PostgreSQL** sidecar plus the Rallly app. Database
migrations run automatically on first boot.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run rallly --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `3010` | Web UI port (`PORT`). |
| `base_url` | `""` → `http://localhost:<port>` | `NEXT_PUBLIC_BASE_URL` — set to your real domain; poll links and emails use it. |
| `secret_password` | `change-me-…` | `SECRET_PASSWORD` — encrypts sessions. **Must be ≥ 32 chars** (`openssl rand -hex 32`). |
| `support_email` | `support@nomploy.local` | `SUPPORT_EMAIL` — from/support address. |
| `db_password` | `rallly` | PostgreSQL password. |
| `db_port` | `5432` | Host port for the bundled PostgreSQL. |
| `db_data_volume` | `rallly_db_data` | `/var/lib/postgresql/data` — all polls. |
| `resources` / `postgres_resources` | see `variables.hcl` | Per-task resources. |

To send email invitations, add SMTP env vars (`SMTP_HOST`, `SMTP_PORT`, `SMTP_USER`,
`SMTP_PWD`, `SMTP_SECURE`, `NOREPLY_EMAIL`) to the `rallly` task. Pin the job to the node holding
the volume with `constraints`. Serves plain HTTP — front it with a reverse proxy for TLS.
