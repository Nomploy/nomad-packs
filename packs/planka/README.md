# planka

[Planka](https://planka.app) — an open-source kanban board (a self-hosted Trello alternative)
with cards, labels, due dates, attachments, and real-time collaboration.

All-in-one host-networked Nomad job: a **PostgreSQL** prestart sidecar plus the **Planka** app.
Boards live in Postgres; uploads have their own volumes.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run planka --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `1337` | Web UI port. |
| `db_port` | `5432` | Co-located PostgreSQL port. |
| `db_password` | `planka` | Password for the Planka Postgres user. |
| `base_url` | `""` | `BASE_URL`; empty = `http://localhost:<port>`. See note. |
| `secret_key` | placeholder | `SECRET_KEY` — set a long random value. |
| `admin_email` / `admin_username` / `admin_password` / `admin_name` | admin defaults | Initial admin. **Change the password.** |
| `*_volume` | named volumes | avatars / backgrounds / attachments / Postgres data. |
| `resources` / `postgres_resources` | see defaults | Per-task resources. |

> Set `base_url` to this node's host/IP or your domain — Planka bakes it into links and its
> realtime origin. **`DEFAULT_ADMIN_*` is re-applied on every boot**: after first login, clear
> `admin_password` (and redeploy) so UI password changes aren't overwritten.

Pin the job to the node holding the volumes with `constraints`.
