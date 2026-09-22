# surrealdb

[SurrealDB](https://surrealdb.com) — a scalable, **multi-model database** (document, graph,
relational, time-series) with a SQL-like query language (SurrealQL), queryable over HTTP and
WebSocket. Host-networked Nomad service with on-disk **RocksDB** storage on a persistent
volume.

## Usage

```sh
nomad-pack registry add nomploy github.com/Nomploy/nomad-packs
nomad-pack run surrealdb --registry nomploy --var root_password=<secret>
```

In nomploy: create a Compose service, type **Nomad Pack**, pack `surrealdb`, set
`root_password`, then Deploy. Endpoint at `http://<node-ip>:8000`.

## Key variables

| Variable | Default | Notes |
|---|---|---|
| `image` | `surrealdb/surrealdb:latest` | Pin a tag in production. |
| `port` | `8000` | HTTP + WebSocket API. |
| `root_user` / `root_password` | `root` / `root` | Root creds, persisted on **first start**. **Change the password.** |
| `data_volume` | `surrealdb_data` | RocksDB storage. Back it up. |
| `constraints` | `[]` | Pin to a node so the local volume stays put. |
| `resources` | `cpu 500 / mem 512` | Raise for larger workloads. |

## Notes

- **Single node.** `count` is fixed to 1 (local RocksDB volume). Pin with `constraints`.
- SurrealDB runs as root in the image, so a fresh volume is writable (no chown).
- Root credentials are persisted after the first start — changing the variables later won't
  change the stored root user; use SurrealQL to manage users.
- No TLS here — front with a reverse proxy and keep it internal.
