# hedgedoc

[HedgeDoc](https://hedgedoc.org) — real-time, collaborative Markdown notes in the browser:
shared editing, presentation mode, diagrams, and more.

All-in-one host-networked Nomad job: a busybox chown init for the uploads volume, a
**PostgreSQL** prestart sidecar, and the **HedgeDoc** app. Notes are stored in Postgres; uploads
on their own volume.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run hedgedoc --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `3011` | Web UI port (`CMD_PORT`). |
| `db_port` | `5432` | Co-located PostgreSQL port. |
| `db_password` | `hedgedoc` | Password for the HedgeDoc Postgres user. |
| `domain` | `""` | `CMD_DOMAIN` (host/IP or domain, no protocol). See note. |
| `allow_anonymous` | `true` | Allow no-login note creation/editing. |
| `uid` | `10000` | User HedgeDoc runs as; uploads volume is chown'd to it. |
| `uploads_volume` | `hedgedoc_uploads` | `/hedgedoc/public/uploads`. |
| `db_data_volume` | `hedgedoc_db_data` | PostgreSQL data — all notes. |
| `resources` / `postgres_resources` | see defaults | Per-task resources. |

> **Set `domain`** to this node's host/IP or your domain. HedgeDoc bakes the domain into
> generated links and its real-time (WebSocket) origin; left empty it defaults to `localhost`,
> which breaks collaborative editing for remote clients. `CMD_URL_ADDPORT=true` keeps the port
> in generated URLs for direct `host:port` access.

Pin the job to the node holding the volumes with `constraints`.
