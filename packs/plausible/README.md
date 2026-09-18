# plausible

[Plausible Community Edition](https://plausible.io) — privacy-friendly, cookie-free web
analytics (a lightweight, GDPR-friendly Google Analytics alternative). **All-in-one**:
Plausible plus its **PostgreSQL** (app data) and **ClickHouse** (event store) in a single
host-networked Nomad job. It creates and migrates both databases on start.

## Usage

```sh
nomad-pack registry add nomploy github.com/Nomploy/nomad-packs
nomad-pack run plausible --registry nomploy \
  --var 'secret_key_base=<64+ char secret>' \
  --var 'base_url=https://analytics.example.com'
```

In nomploy: create a Compose service, type **Nomad Pack**, pack `plausible`, set the
variables, then Deploy.

Open `http://<node-ip>:8000` and register the first account (that's the admin), then set
`disable_registration` to lock it down.

## Key variables

| Variable | Default | Notes |
|---|---|---|
| `image` | `ghcr.io/plausible/community-edition:v3.0.1` | Pin a supported version. |
| `port` | `8000` | Web UI (`HTTP_PORT`). |
| `base_url` | `""` | Public URL; empty → `http://localhost:<port>`. Set it for real use. |
| `secret_key_base` | placeholder | **Must be ≥ 64 chars — change it** (`openssl rand -base64 64`). |
| `disable_registration` | `false` | `false` / `true` / `invite_only`. |
| `db_password` | `plausible` | Postgres password. **Change this.** |
| `db_data_volume` / `clickhouse_data_volume` | `plausible_*` | Back both up. |
| `db_port` / `clickhouse_port` | `5432` / `8123` | Bundled DB host ports. |
| `constraints` | `[]` | Pin to a node so the volumes stay put. |

Per-task resources: `plausible_resources`, `postgres_resources`, `clickhouse_resources`.

## Notes

- **Single node.** `count` is fixed to 1 (local Postgres + ClickHouse volumes). Pin with
  `constraints`. The bundled Postgres/ClickHouse bind host ports (5432 / 8123 / 9000) — keep
  them off nodes already running the `postgres`/`clickhouse` packs, or change `db_port`.
- **Secrets:** set a real `secret_key_base` and DB password; front with a reverse proxy for
  TLS and set `base_url` to the HTTPS URL.
- **Backups:** snapshot both volumes — Postgres holds accounts/sites, ClickHouse holds the
  event data.
- vs the `umami` pack: Plausible is heavier (adds ClickHouse) but scales to larger event
  volumes; `umami` is a lighter Postgres-only option.
