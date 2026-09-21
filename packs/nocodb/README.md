# nocodb

[NocoDB](https://nocodb.com) — an open-source **Airtable alternative** that turns a database
into a smart spreadsheet: grid/kanban/gallery views, forms, and an auto-generated REST API.
**All-in-one**: NocoDB plus its **PostgreSQL** metadata database in a single host-networked
Nomad job (Postgres as a prestart sidecar). NocoDB migrates on start.

## Usage

```sh
nomad-pack registry add nomploy github.com/Nomploy/nomad-packs
nomad-pack run nocodb --registry nomploy
```

In nomploy: create a Compose service, type **Nomad Pack**, pack `nocodb`, custom registry
`github.com/Nomploy/nomad-packs`, then Deploy.

Open `http://<node-ip>:8098` and create the super-admin account on first visit.

## Key variables

| Variable | Default | Notes |
|---|---|---|
| `image` | `nocodb/nocodb:latest` | Pin a tag in production. |
| `port` | `8098` | Web UI / API. |
| `public_url` | `""` | Public URL (`NC_PUBLIC_URL`) for links/emails. |
| `jwt_secret` | `""` | Auth-token secret; set a stable value in production. |
| `db_password` | `nocodb` | Postgres password. **Change this.** |
| `db_data_volume` | `nocodb_db_data` | Metadata (bases/views/users). Back it up. |
| `data_volume` | `nocodb_data` | Uploads/attachments. Back it up. |
| `db_port` | `5432` | Bundled Postgres host port. |
| `constraints` | `[]` | Pin to a node so the volumes stay put. |

Per-task resources: `nocodb_resources`, `postgres_resources`.

## Notes

- **Single node.** `count` is fixed to 1 (local Postgres + uploads volumes). Pin with
  `constraints`.
- Front with a reverse proxy for TLS; set `public_url` to the HTTPS address.
- **Backups:** snapshot both volumes — Postgres holds your bases/metadata, `/usr/app/data`
  holds uploaded attachments.
