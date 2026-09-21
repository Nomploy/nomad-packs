# ghost

[Ghost](https://ghost.org) — a professional publishing platform for blogs, newsletters, and
paid memberships. **All-in-one**: Ghost plus its **MySQL 8** database in a single
host-networked Nomad job (Ghost 5 requires MySQL 8 — MariaDB isn't supported). MySQL runs
as a prestart sidecar; Ghost migrates on start.

## Usage

```sh
nomad-pack registry add nomploy github.com/Nomploy/nomad-packs
nomad-pack run ghost --registry nomploy --var 'url=https://blog.example.com'
```

In nomploy: create a Compose service, type **Nomad Pack**, pack `ghost`, set `url`, then
Deploy. Open `<url>/ghost` and create the owner account.

## Key variables

| Variable | Default | Notes |
|---|---|---|
| `image` | `ghost:5-alpine` | Pin a tag in production. |
| `port` | `2368` | Site + admin. |
| `url` | `""` | Public URL — **set it** (Ghost bakes it into links); empty → `http://localhost:<port>`. |
| `db_password` / `db_root_password` | `ghost` | MySQL creds. **Change them.** |
| `content_volume` | `ghost_content` | Themes/images/uploads. Back it up. |
| `db_data_volume` | `ghost_db_data` | The database. Back it up. |
| `db_port` | `3306` | Bundled MySQL host port. |
| `constraints` | `[]` | Pin to a node so the volumes stay put. |

Per-task resources: `ghost_resources`, `mysql_resources`.

## Notes

- **Single node.** `count` is fixed to 1 (local MySQL + content volumes). A prestart task
  chowns the content volume to uid 1000 (the `node` user). Pin with `constraints`.
- **Email:** member signups / newsletters need SMTP — configure `mail__*` env or Ghost's
  settings after first boot (not set here).
- Front with a reverse proxy for TLS and set `url` to the HTTPS address.
- **Backups:** snapshot both volumes (database + content).
