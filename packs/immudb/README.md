# immudb

[immudb](https://immudb.io) — a lightweight, high-speed **immutable** database. Data can be appended and
read but not silently changed or deleted, and every entry is cryptographically verifiable — giving you a
tamper-evident history that's ideal for audit logs, transactions, and compliance. Supports both SQL and
key-value, with a web console and clients in many languages.

Single host-networked Nomad service with a persistent data volume.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run immudb --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `3322` | DB protocol port (`IMMUDB_PORT`) — gRPC and PostgreSQL/MySQL wire. |
| `web_port` | `8085` | Web console port (`IMMUDB_WEB_SERVER_PORT`). |
| `admin_password` | `Change-me-1!` | Admin password (`IMMUDB_ADMIN_PASSWORD`). **Change it** — needs upper/lower/digit/symbol, 8+ chars. |
| `data_volume` | `immudb_data` | `/var/lib/immudb` — all databases and their verifiable history. |
| `image` | `codenotary/immudb:latest` | Container image. Pin a tag in production. |
| `resources` | `{ cpu = 500, memory = 512 }` | Task resources. |

Connect with the `immuclient` CLI, the official SDKs (Go, Python, Java, Node, .NET), or via the
PostgreSQL/MySQL wire protocol. Log in as `immudb` with your admin password and change it. Keep the DB
port on an internal network. Pin the job to the node holding the volume with `constraints`.
