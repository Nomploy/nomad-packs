# windmill

[Windmill](https://www.windmill.dev/) — a developer platform that turns **scripts into workflows, UIs and cron jobs**.
Write Python, TypeScript, Go, Bash or SQL and get auto-generated UIs, a flow builder, schedules, approvals and an app
editor — an open-source alternative to Airplane, Retool and n8n. This pack runs Windmill in **standalone** mode
(server + embedded worker) with a **bundled PostgreSQL**.

Single host-networked group: `windmill` + `postgres`.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run windmill --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `8000` | Web UI port. |
| `base_url` | `""` | Public URL (`BASE_URL`). Empty = `http://localhost:<port>`. |
| `db_password` | `change-me-…` | **Change this.** Database password. |
| `image` | `ghcr.io/windmill-labs/windmill:latest` | App image. Pin a tag in production. |
| `postgres_image` | `postgres:16` | Bundled database image. |
| `data_volume` | `windmill_cache` | `/tmp/windmill` — worker dependency cache. |
| `db_data_volume` | `windmill_db` | PostgreSQL data — holds all Windmill state. |
| `db_port` | `5432` | Loopback PostgreSQL port. |
| `resources` / `db_resources` | … | Per-task resources. |

> Windmill runs its database migrations on start; the first account you create becomes the superadmin. `standalone` mode
> bundles the server and one worker in a single container — for heavier workloads, scale out with dedicated worker
> deployments. Postgres holds the entire state, so pin the job to the node holding the volumes with `constraints` and
> back it up.
