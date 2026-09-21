# ferretdb

[FerretDB](https://www.ferretdb.com) — an open-source, **Apache-2.0** database that speaks
the **MongoDB wire protocol**, built on PostgreSQL. A drop-in for apps and tools that use
MongoDB drivers, without MongoDB's SSPL license. **All-in-one**: FerretDB v2 plus its
required **DocumentDB-enabled PostgreSQL** in a single host-networked Nomad job (Postgres as
a prestart sidecar). FerretDB is stateless — all data lives in Postgres.

## Usage

```sh
nomad-pack registry add nomploy github.com/Nomploy/nomad-packs
nomad-pack run ferretdb --registry nomploy --var db_password=<secret>
```

In nomploy: create a Compose service, type **Nomad Pack**, pack `ferretdb`, set
`db_password`, then Deploy.

Connect any MongoDB client/driver:

```
mongodb://ferretdb:<db_password>@<node-ip>:27017/
```

## Key variables

| Variable | Default | Notes |
|---|---|---|
| `image` | `ghcr.io/ferretdb/ferretdb:2` | FerretDB v2. Pin a full tag in production. |
| `postgres_image` | `ghcr.io/ferretdb/postgres-documentdb:17` | **Required** DocumentDB image; keep the major matched to a tested FerretDB version. |
| `port` | `27017` | MongoDB wire protocol. |
| `db_user` / `db_password` | `ferretdb` / `ferretdb` | Also the Mongo username/password. **Change the password.** |
| `db_data_volume` | `ferretdb_db_data` | All documents. Back it up. |
| `db_port` | `5432` | Bundled Postgres host port. |
| `constraints` | `[]` | Pin to a node so the volume stays put. |

Per-task resources: `ferretdb_resources`, `postgres_resources`.

## Notes

- **Single node.** `count` is fixed to 1 (local Postgres volume). Pin with `constraints`.
- **Version pairing:** FerretDB v2 requires the `postgres-documentdb` image (the DocumentDB
  extension is preloaded there — a plain Postgres won't work). The `:17`/`:16`/`:15` tags
  move; pin full tags together (e.g. `postgres-documentdb:17-0.107.0-ferretdb-2.7.0` with
  `ferretdb:2.7.0`) for reproducibility.
- **Compatibility:** FerretDB covers a large subset of MongoDB — check FerretDB's
  compatibility docs for your workload before relying on it.
