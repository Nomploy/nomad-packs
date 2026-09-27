# ryot

[Ryot](https://ryot.io/) (Roll Your Own Tracker) — a self-hosted tracker for **everything you consume**: movies, TV,
books, video games, podcasts, audiobooks, manga, anime and more. Log progress, keep watchlists and reading lists, import
from Trakt/Goodreads/etc., and see rich stats. This pack is **batteries-included** with a bundled PostgreSQL.

Single host-networked group: `ryot` + `postgres`.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run ryot --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `8000` | Web UI port. |
| `admin_access_token` | `change-me-…` | **Change this.** Admin/API token (`SERVER_ADMIN_ACCESS_TOKEN`). |
| `db_password` | `change-me-…` | **Change this.** Bundled PostgreSQL password. |
| `image` | `ignisda/ryot:latest` | App image. Pin a tag in production. |
| `postgres_image` | `postgres:17-alpine` | Bundled database image. |
| `db_data_volume` | `ryot_db` | PostgreSQL data — all your tracking data. |
| `db_port` | `5432` | Loopback PostgreSQL port. |
| `resources` / `db_resources` | … | Per-task resources. |

> Ryot runs database migrations automatically on start; the first account you register becomes the owner. Because
> Postgres holds all your data, pin the job to the node holding the volume with `constraints` and back it up.
