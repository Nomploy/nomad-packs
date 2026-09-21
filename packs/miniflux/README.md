# miniflux

[Miniflux](https://miniflux.app) — a minimalist, fast, self-hosted **RSS/Atom feed reader**
with a clean reading UI, keyboard shortcuts, and a REST API. **All-in-one**: Miniflux plus
its **PostgreSQL** database in a single host-networked Nomad job. It runs migrations and
creates the admin on first start.

## Usage

```sh
nomad-pack registry add nomploy github.com/Nomploy/nomad-packs
nomad-pack run miniflux --registry nomploy --var admin_password=<secret>
```

In nomploy: create a Compose service, type **Nomad Pack**, pack `miniflux`, set
`admin_password`, then Deploy. Open `http://<node-ip>:8100` and log in as `admin`.

## Key variables

| Variable | Default | Notes |
|---|---|---|
| `image` | `miniflux/miniflux:latest` | Pin a tag in production. |
| `port` | `8100` | Web UI / API (`LISTEN_ADDR`). |
| `admin_user` / `admin_password` | `admin` / `changeme` | Created on **first boot**. **Change the password** (min 6 chars). |
| `base_url` | `""` | Public URL when behind a domain. |
| `db_password` | `miniflux` | Postgres password. **Change this.** |
| `db_data_volume` | `miniflux_db_data` | Feeds/entries/users. Back it up. |
| `db_port` | `5432` | Bundled Postgres host port. |
| `constraints` | `[]` | Pin to a node so the volume stays put. |

Per-task resources: `miniflux_resources`, `postgres_resources`.

## Notes

- **Single node.** `count` is fixed to 1 (local Postgres volume). Pin with `constraints`.
- Miniflux itself is stateless — all data is in Postgres, so back up the `db_data_volume`.
- Front with a reverse proxy for TLS and set `base_url` to the HTTPS URL.
