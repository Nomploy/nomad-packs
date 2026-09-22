# pgadmin

[pgAdmin 4](https://www.pgadmin.org) — the popular web-based administration and development
tool for **PostgreSQL** (browse schemas, run queries, manage roles, view plans). Pairs with
the `postgres` pack. Host-networked Nomad service with a persistent volume for saved servers
and settings.

## Usage

```sh
nomad-pack registry add nomploy github.com/Nomploy/nomad-packs
nomad-pack run pgadmin --registry nomploy --var password=<secret>
```

In nomploy: create a Compose service, type **Nomad Pack**, pack `pgadmin`, set `password`,
then Deploy. Open `http://<node-ip>:5050` and log in with `email` / `password`, then add a
server (host `127.0.0.1`, port `5432` for the postgres pack on the same node).

## Key variables

| Variable | Default | Notes |
|---|---|---|
| `image` | `dpage/pgadmin4:latest` | Pin a tag in production. |
| `port` | `5050` | Web UI (`PGADMIN_LISTEN_PORT`). |
| `email` | `admin@example.com` | Login email — **must be a valid email format**. |
| `password` | `admin` | **Change this.** |
| `data_volume` | `pgadmin_data` | Saved connections + prefs. |
| `constraints` | `[]` | Pin to a node so the local volume stays put. |
| `resources` | `cpu 300 / mem 256` | Lightweight. |

## Notes

- **Single node.** `count` is fixed to 1 (local volume). A prestart task chowns the volume
  to uid 5050 (the pgadmin user). Pin with `constraints`.
- Serves plain HTTP — front with a reverse proxy for TLS. It can reach any Postgres your
  node can reach; keep pgAdmin itself internal.
