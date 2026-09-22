# questdb

[QuestDB](https://questdb.io) — a high-performance time-series database with SQL, a fast InfluxDB
Line Protocol ingestion endpoint, the PostgreSQL wire protocol, and a built-in web console.

Single host-networked Nomad service with a persistent data volume.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run questdb --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `http_port` | `9000` | Web console + REST API. |
| `pg_port` | `8812` | PostgreSQL wire protocol. |
| `ilp_port` | `9009` | InfluxDB Line Protocol (TCP). |
| `data_volume` | `questdb_data` | `/var/lib/questdb`. |
| `image` | `questdb/questdb:latest` | Container image. Pin a tag in production. |
| `resources` | `{ cpu = 1000, memory = 1024 }` | Task resources. |

Connect any Postgres client with user `admin` / password `quest` (change it for production). Pin
the job to the node holding the volume with `constraints`.
