# wikijs

[Wiki.js](https://js.wiki) — a modern, powerful wiki with a Markdown/WYSIWYG editor, full-text
search, granular access control, and Git/storage sync.

All-in-one host-networked Nomad job: a **PostgreSQL** prestart sidecar plus the **Wiki.js** app.
Content is stored in Postgres, so only the database needs a volume.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run wikijs --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `3010` | Web UI port (`PORT`). |
| `db_port` | `5432` | Co-located PostgreSQL port. |
| `db_password` | `wikijs` | Password for the Wiki.js Postgres user. |
| `db_data_volume` | `wikijs_db_data` | `/var/lib/postgresql/data` — all wiki content. |
| `image` | `ghcr.io/requarks/wiki:2` | Wiki.js image. Pin a tag in production. |
| `postgres_image` | `postgres:16-alpine` | Database image. |
| `resources` / `postgres_resources` | see defaults | Per-task resources. |

Complete the setup wizard on first visit to create the administrator. Pin the job to the node
holding `db_data_volume` with `constraints`.
