# timescaledb

[TimescaleDB](https://www.timescale.com) — **PostgreSQL** with the TimescaleDB extension for
high-performance **time-series** data: hypertables, continuous aggregates, and compression,
all with full SQL and the Postgres ecosystem. Host-networked Nomad service with a persistent
volume. A drop-in Postgres that's tuned for metrics/events/IoT.

## Usage

```sh
nomad-pack registry add nomploy github.com/Nomploy/nomad-packs
nomad-pack run timescaledb --registry nomploy --var db_password=<secret>
```

In nomploy: create a Compose service, type **Nomad Pack**, pack `timescaledb`, set
`db_password`, then Deploy. Connect at `<node-ip>:5432`.

Enable the extension in your database and create a hypertable:

```sql
CREATE EXTENSION IF NOT EXISTS timescaledb;
```

## Key variables

| Variable | Default | Notes |
|---|---|---|
| `image` | `timescale/timescaledb:latest-pg16` | Pin a tag in production. |
| `port` | `5432` | Host port. |
| `db_name` / `db_user` / `db_password` | `app` / `app` / `timescale` | Created on first boot. **Change the password.** |
| `data_volume` | `timescaledb_data` | Persistent data dir. Back it up. |
| `constraints` | `[]` | Pin to a node so the local volume stays put. |
| `resources` | `cpu 500 / mem 512` | Raise for larger workloads. |

## Notes

- **Single node.** Keep `count` at 1 — local volume, no built-in replication. Pin with
  `constraints`.
- Credentials/database are applied **only on first boot** (empty data dir).
- It's PostgreSQL under the hood — the `adminer`/`pgadmin` packs manage it too.
- **Backups:** snapshot the `data_volume`, or `pg_dump`.
