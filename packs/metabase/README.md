# metabase

[Metabase](https://www.metabase.com) — open-source business intelligence: dashboards,
ad-hoc questions, and SQL over your databases, with a friendly UI. Point it at your data
sources (the `postgres`, `mariadb`, or `clickhouse` packs, or anything else).

This pack is **all-in-one**: Metabase plus its **application PostgreSQL** in a single
host-networked Nomad job. It deliberately uses Postgres rather than Metabase's embedded H2
database, which Metabase itself warns is not safe for real use. Postgres starts first
(prestart sidecar); Metabase reaches it on `127.0.0.1` and migrates on start.

## Usage

```sh
nomad-pack registry add nomploy github.com/Nomploy/nomad-packs
nomad-pack run metabase --registry nomploy
```

In nomploy: create a Compose service, type **Nomad Pack**, pack `metabase`, custom
registry `github.com/Nomploy/nomad-packs`, then Deploy.

Open `http://<node-ip>:3003` and complete the setup wizard. **First boot is slow** —
Metabase initializes and migrates its application database before serving.

## Key variables

| Variable | Default | Notes |
|---|---|---|
| `image` | `metabase/metabase:latest` | Pin a tag in production. |
| `port` | `3003` | Web UI (off 3000/3001/3002 to dodge panel/grafana/gitea). |
| `site_url` | `""` | Public URL when fronted by a domain. |
| `encryption_key` | `""` | Encrypts stored data-source credentials at rest; keep it stable. |
| `db_password` | `metabase` | App Postgres password. **Change this.** |
| `db_data_volume` | `metabase_db_data` | Dashboards/questions/users live here — back it up. |
| `db_port` | `5432` | Bundled Postgres host port. |
| `constraints` | `[]` | Pin to a node so the DB volume stays put. |

Per-task resources: `metabase_resources` (JVM — default cpu 1000 / mem 2048),
`postgres_resources`.

## Notes

- **Single node.** `count` is fixed to 1 (local Postgres volume). Pin with `constraints`.
- **Data sources:** add them from the UI after setup — e.g. the `postgres` pack at
  `127.0.0.1:5432`, `clickhouse` at `:8123`, `mariadb` at `:3306` (same node), or any
  reachable host.
- **Backups:** snapshot the `db_data_volume` (or `pg_dump` the `metabase` database).
- Front with a reverse proxy for TLS; set `site_url` to the public URL.
