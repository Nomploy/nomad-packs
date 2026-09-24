# libsql

[libSQL server](https://turso.tech/libsql) (`sqld`) — a self-hosted server for **libSQL**, the
open-source fork of SQLite maintained by Turso. You keep SQLite's simplicity and single-file storage but
add a network **HTTP/gRPC API**, so multiple applications (and edge/embedded replicas) can share one
database.

Single host-networked Nomad service running a primary node, with a persistent data volume.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run libsql --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `8121` | HTTP API port (`SQLD_HTTP_LISTEN_ADDR`). |
| `auth_jwt_key` | `""` | JWT public key (`SQLD_AUTH_JWT_KEY`) to require auth. Empty = **no auth**. |
| `data_volume` | `libsql_data` | `/var/lib/sqld` — the database files. |
| `image` | `ghcr.io/tursodatabase/libsql-server:latest` | Container image. Pin a tag in production. |
| `resources` | `{ cpu = 500, memory = 256 }` | Task resources. |

Connect with a libSQL/Turso client (`http://<node-ip>:8121`) or any libSQL driver; health check at
`/health`. By default there is **no authentication** — set `auth_jwt_key` and keep the port on an internal
network. This runs a single **primary** node; embedded replicas can sync from it. Pin the job to the node
holding the volume with `constraints`.
