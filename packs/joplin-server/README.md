# joplin-server

[Joplin Server](https://joplinapp.org) — the self-hosted sync backend for the
[Joplin](https://joplinapp.org) note-taking apps. Keep notes, notebooks, tags, and attachments in sync
across desktop and mobile, with end-to-end encryption and notebook sharing between users — all on your own
infrastructure.

All-in-one host-networked Nomad job: the **Joplin Server** app plus a **PostgreSQL** sidecar. Database
migrations run automatically on boot.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run joplin-server --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `22300` | Web app port (`APP_PORT`). |
| `base_url` | `""` → `http://localhost:<port>` | `APP_BASE_URL` — set to your real domain; clients sync against it. |
| `db_password` | `joplin` | PostgreSQL password. |
| `db_port` | `5432` | Host port for the bundled PostgreSQL. |
| `db_data_volume` | `joplin_db_data` | `/var/lib/postgresql/data` — all synced notes. |
| `image` | `joplin/server:latest` | App image. Pin a tag in production. |
| `resources` / `postgres_resources` | see `variables.hcl` | Per-task resources. |

Log in to the admin panel at `http://<node-ip>:22300` with `admin@localhost` / `admin` and **change the
password immediately**. In the Joplin apps, choose the **Joplin Server** sync target and enter your
`base_url` plus your account email/password. Set `base_url` correctly — clients rely on it. Serves plain
HTTP — front it with a reverse proxy for TLS. Pin the job to the node holding the volume with
`constraints`.
