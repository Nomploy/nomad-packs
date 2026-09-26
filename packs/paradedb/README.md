# paradedb

[ParadeDB](https://www.paradedb.com/) — a **PostgreSQL** distribution with full-text search (BM25) and analytics
built in, a Postgres-native alternative to bolting on Elasticsearch. It's wire-compatible with Postgres, so existing
drivers, ORMs and tools just work — you get `pg_search` and columnar analytics inside your database.

Single host-networked Nomad service with a persistent data volume.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run paradedb --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `5432` | PostgreSQL port (`PGPORT`). |
| `db_name` | `paradedb` | Initial database (`POSTGRES_DB`). |
| `db_user` | `postgres` | Superuser name (`POSTGRES_USER`). |
| `db_password` | `change-me-…` | **Change this.** Superuser password (`POSTGRES_PASSWORD`). |
| `image` | `paradedb/paradedb:latest` | Container image. Pin a tag in production. |
| `data_volume` | `paradedb_data` | `/var/lib/postgresql/data`. |
| `resources` | `{ cpu = 500, memory = 512 }` | Task resources. |

> Connect with any Postgres client: `postgres://postgres:<password>@<host>:5432/paradedb`. Enable search with
> `CREATE EXTENSION pg_search;`. Because the database lives on the volume, pin the job to the node holding it with
> `constraints` and back it up.
