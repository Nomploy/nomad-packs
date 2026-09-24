# teammapper

[TeamMapper](https://github.com/b310-digital/teammapper) — a simple, self-hosted tool for creating and
sharing **mind maps** and collaborating on them in **real time**. Share a map's link and work on it together,
no accounts required.

All-in-one host-networked Nomad job: the **TeamMapper** app plus a **PostgreSQL** sidecar.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run teammapper --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `3000` | Web app port (`PORT`). The container listens on 3000. |
| `delete_after_days` | `30` | Prune maps not accessed for N days (`DELETE_AFTER_DAYS`); `0` = never. |
| `db_password` | `teammapper` | PostgreSQL password. |
| `db_port` | `5432` | Host port for the bundled PostgreSQL. |
| `db_data_volume` | `teammapper_db_data` | `/var/lib/postgresql/data` — all mind maps. |
| `image` | `ghcr.io/b310-digital/teammapper:main` | App image. Pin a tag in production. |
| `resources` / `postgres_resources` | see `variables.hcl` | Per-task resources. |

Open the app, create a map, and share its link to collaborate live. Old, untouched maps are pruned per
`delete_after_days`. Serves plain HTTP — front it with a reverse proxy for TLS. Pin the job to the node
holding the volume with `constraints`.
