# clickhouse

[ClickHouse](https://clickhouse.com) — a fast, open-source column-oriented **OLAP**
database for real-time analytics over large datasets. Deployed as a host-networked Nomad
service with a persistent Docker volume.

## Usage

```sh
nomad-pack registry add nomploy github.com/Nomploy/nomad-packs
nomad-pack run clickhouse --registry nomploy
```

In nomploy: create a Compose service, type **Nomad Pack**, pack `clickhouse`, custom
registry `github.com/Nomploy/nomad-packs`, then Deploy.

- **HTTP** — `http://<node-ip>:8123` (most clients + the `/play` query UI).
- **Native** — `<node-ip>:9000` (`clickhouse-client`, native drivers).

## Key variables

| Variable | Default | Notes |
|---|---|---|
| `image` | `clickhouse/clickhouse-server:latest` | Pin a tag in production. |
| `http_port` / `tcp_port` | `8123` / `9000` | Set via a config.d override; change `tcp_port` if 9000 is taken. |
| `db_name` / `db_user` / `db_password` | `default` / `default` / `clickhouse` | Created on **first boot**. Change the password (empty = no password). |
| `data_volume` | `clickhouse_data` | `/var/lib/clickhouse`. Back it up. |
| `constraints` | `[]` | Pin to a node so the local volume stays put. |
| `resources` | `cpu 1000 / mem 2048` | ClickHouse is memory-hungry; raise for real workloads. |

## Notes

- **Single node.** `count` is fixed to 1 (local volume). Pin with `constraints`. A
  ClickHouse cluster (shards/replicas + Keeper) is out of scope for this pack.
- A raised open-files `ulimit` (262144) is set, as ClickHouse recommends.
- Credentials/database apply only on **first boot** with an empty volume.
- **Backups:** snapshot the `data_volume`, or use `BACKUP`/`clickhouse-backup`.
