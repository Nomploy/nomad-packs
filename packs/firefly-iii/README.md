# firefly-iii

[Firefly III](https://www.firefly-iii.org) — a self-hosted personal finance manager: track accounts,
budgets, bills, and categories with rich reports and a double-entry ledger.

All-in-one host-networked Nomad job: a busybox chown init, a **MariaDB** prestart sidecar, and the
**Firefly III** app.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run firefly-iii --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `8080` | Web UI port (fixed — see note). |
| `db_port` | `3306` | Co-located MariaDB port. |
| `db_password` | `firefly` | Database password. |
| `app_key` | 32-char placeholder | Laravel `APP_KEY` — **must be exactly 32 chars; change it.** |
| `app_url` | `""` | `APP_URL`; empty = `http://localhost:<port>`. |
| `uid` | `33` | User the app runs as (www-data); upload volume chown'd to it. |
| `upload_volume` / `db_data_volume` | named volumes | Uploads / MariaDB data. |
| `resources` / `mariadb_resources` | see defaults | Per-task resources. |

> **`app_key` must be exactly 32 characters.** The app's Apache binds **8080** with no env to change
> it — front it with a reverse proxy (or the `nginx-proxy-manager`/`caddy` pack) to serve on another
> port/domain (8080 overlaps several packs). Pin the job to the node holding the volumes with
> `constraints`.
