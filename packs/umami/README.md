# umami

[Umami](https://umami.is) — simple, privacy-friendly, open-source web analytics: a
cookie-free, GDPR-friendly alternative to Google Analytics. **All-in-one**: Umami plus its
**PostgreSQL** database in a single host-networked Nomad job (Postgres as a prestart
sidecar). Umami runs its schema migrations on start.

## Usage

```sh
nomad-pack registry add nomploy github.com/Nomploy/nomad-packs
nomad-pack run umami --registry nomploy
```

In nomploy: create a Compose service, type **Nomad Pack**, pack `umami`, custom registry
`github.com/Nomploy/nomad-packs`, then Deploy.

Open `http://<node-ip>:3005` and log in with **admin / umami** — change the password
immediately. Add your website to get the tracking `<script>`.

## Key variables

| Variable | Default | Notes |
|---|---|---|
| `image` | `ghcr.io/umami-software/umami:postgresql-latest` | Pin a tag in production. |
| `port` | `3005` | Web UI / tracking endpoint (off 3000–3003 to dodge other packs). |
| `app_secret` | `""` | Random string to sign tokens; keep it stable. |
| `db_password` | `umami` | App Postgres password. **Change this.** |
| `db_data_volume` | `umami_db_data` | Analytics data. Back it up. |
| `db_port` | `5432` | Bundled Postgres host port. |
| `constraints` | `[]` | Pin to a node so the DB volume stays put. |

Per-task resources: `umami_resources`, `postgres_resources`.

## Notes

- **Single node.** `count` is fixed to 1 (local Postgres volume). Pin with `constraints`.
- Front with a reverse proxy for TLS; the tracking script should be served over HTTPS.
- **Backups:** snapshot the `db_data_volume` (or `pg_dump` the `umami` database).
