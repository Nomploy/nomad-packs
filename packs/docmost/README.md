# docmost

[Docmost](https://docmost.com) — an open-source collaborative **wiki and documentation**
platform (spaces, nested pages, real-time editing, comments) — a self-hosted
Confluence/Notion alternative. **All-in-one**: Docmost plus **PostgreSQL** and **Redis** in
a single host-networked Nomad job.

## Usage

```sh
nomad-pack registry add nomploy github.com/Nomploy/nomad-packs \
  --var app_secret=$(openssl rand -hex 32)
nomad-pack run docmost --registry nomploy --var app_secret=$(openssl rand -hex 32)
```

In nomploy: create a Compose service, type **Nomad Pack**, pack `docmost`, set `app_secret`
(and `app_url`), then Deploy. Open `http://<node-ip>:3007` and create the first workspace +
admin account.

## Key variables

| Variable | Default | Notes |
|---|---|---|
| `image` | `docmost/docmost:latest` | Pin a tag in production. |
| `port` | `3007` | Web app. |
| `app_secret` | placeholder | **≥32 chars — change it** (`openssl rand -hex 32`); keep it stable. |
| `app_url` | `""` | Public URL for links/email. |
| `db_password` | `docmost` | Postgres password. **Change this.** |
| `db_data_volume` | `docmost_db_data` | Pages/spaces/users. Back it up. |
| `storage_volume` | `docmost_storage` | Uploaded attachments. Back it up. |
| `db_port` / `redis_port` | `5432` / `6379` | Bundled dependency ports. |
| `constraints` | `[]` | Pin to a node so the volumes stay put. |

Per-task resources: `docmost_resources`, `postgres_resources`.

## Notes

- **Single node.** `count` is fixed to 1 (local Postgres + storage volumes). A prestart task
  chowns the uploads volume to uid 1000. Pin with `constraints`.
- **Redis is ephemeral** (queues/websockets) — losing it on restart is fine.
- Front with a reverse proxy for TLS and set `app_url`. Email (invites) needs SMTP env
  (`MAIL_*`) — add it if you want member email.
- **Backups:** snapshot both the DB and storage volumes.
