# teable

[Teable](https://teable.io/) — a no-code **database and spreadsheet** platform, an Airtable alternative built on
PostgreSQL. Rich field types, grid/kanban/gallery/form views, real-time collaboration, a full REST API and automations —
with the scalability of a real SQL database underneath. This pack is **batteries-included**: the app plus bundled
PostgreSQL and Redis.

Single host-networked group: `teable` + `postgres` + `redis`.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run teable --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `3000` | Web UI port. |
| `base_url` | `""` | Public URL (`PUBLIC_ORIGIN`). Empty = `http://localhost:<port>`. Set to your real host. |
| `secret_key` | `change-me-…` | **Change this.** Signs tokens/sessions. `openssl rand -base64 32`. |
| `db_password` / `redis_password` | `change-me-…` | **Change these.** Database and cache passwords. |
| `image` | `ghcr.io/teableio/teable:latest` | App image. Pin a tag in production. |
| `postgres_image` / `redis_image` | `postgres:16` / `redis:7` | Bundled service images. |
| `data_volume` / `db_data_volume` | … | Attachments (`/app/.assets`) and PostgreSQL data. |
| `db_port` / `redis_port` | `5432` / `6379` | Loopback ports for the bundled services. |
| `resources` / `db_resources` / `redis_resources` | … | Per-task resources. |

> Teable runs database migrations automatically on start; the first account you register becomes the admin. Set
> `base_url` to the address users actually open. Because Postgres holds all data, pin the job to the node holding the
> volumes with `constraints` and back it up.
