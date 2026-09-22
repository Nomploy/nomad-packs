# directus

[Directus](https://directus.io) — an open-source **headless CMS and data platform**: point
it at a SQL database and get an instant REST + GraphQL API plus a polished no-code admin
app. **All-in-one**: Directus plus **PostgreSQL** in a single host-networked Nomad job
(Postgres as a prestart sidecar). It bootstraps the schema and admin on first start.

## Usage

```sh
nomad-pack registry add nomploy github.com/Nomploy/nomad-packs
nomad-pack run directus --registry nomploy \
  --var key=$(openssl rand -hex 16) --var secret=$(openssl rand -hex 16) \
  --var admin_password=<secret>
```

In nomploy: create a Compose service, type **Nomad Pack**, pack `directus`, set
`key`/`secret`/`admin_password`, then Deploy. Open `http://<node-ip>:8055` and log in.

## Key variables

| Variable | Default | Notes |
|---|---|---|
| `image` | `directus/directus:latest` | Pin a tag in production. |
| `port` | `8055` | App / API. |
| `key` / `secret` | placeholders | **Change both** (random strings) and keep them stable. |
| `admin_email` / `admin_password` | `admin@example.com` / `admin` | First admin, **first boot only**. Change the password. |
| `public_url` | `""` | Public URL when behind a domain. |
| `db_password` | `directus` | Postgres password. **Change this.** |
| `db_data_volume` / `uploads_volume` | `directus_*` | Back both up. |
| `db_port` | `5432` | Bundled Postgres host port. |
| `constraints` | `[]` | Pin to a node so the volumes stay put. |

Per-task resources: `directus_resources`, `postgres_resources`.

## Notes

- **Single node.** `count` is fixed to 1 (local Postgres + uploads volumes). A prestart task
  chowns the uploads volume to uid 1000. Pin with `constraints`.
- Front with a reverse proxy for TLS and set `public_url`.
- **Backups:** snapshot both volumes (database + uploads).
