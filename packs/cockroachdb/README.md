# cockroachdb

[CockroachDB](https://www.cockroachlabs.com/docs/) — a distributed SQL database that speaks the
**PostgreSQL wire protocol**, with strong consistency and horizontal scale.

This pack runs a **single-node, insecure** instance (great for dev/homelab), host-networked with
a data volume and the built-in DB Console.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run cockroachdb --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `sql_port` | `26257` | SQL / Postgres wire port. |
| `http_port` | `8085` | DB Console (web UI) port. |
| `data_volume` | `cockroachdb_data` | `/cockroach/cockroach-data` — the store. |
| `image` | `cockroachdb/cockroach:latest` | Container image. Pin a tag in production. |
| `resources` | `{ cpu = 1000, memory = 1024 }` | Task resources. |

## Connect

```sh
# any Postgres client, user "root", no password (insecure mode)
psql "postgresql://root@<node-ip>:26257/defaultdb?sslmode=disable"
```

> **`--insecure`** means no authentication and no TLS — use only on a trusted network. For
> production, run a secure multi-node cluster with certificates. Pin the job to the node holding
> the volume with `constraints`.
