# forgejo

[Forgejo](https://forgejo.org) — a self-hosted, **community-governed** Git forge (a hard fork of Gitea).
Repositories, issues, pull requests, releases, wikis, a package registry, and CI via **Forgejo Actions** —
lightweight, fast, and fully in your control.

Single host-networked Nomad service using **SQLite** with a persistent data volume.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run forgejo --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `http_port` | `3030` | Web UI / API port. |
| `ssh_port` | `2223` | Git-over-SSH port. |
| `root_url` | `""` | `ROOT_URL` — set to your real domain so clone URLs/links are correct. |
| `data_volume` | `forgejo_data` | `/data` — SQLite DB, repositories, config. |
| `image` | `codeberg.org/forgejo/forgejo:latest` | Container image. Pin a tag in production. |
| `resources` | `{ cpu = 500, memory = 512 }` | Task resources. |

Open the web UI and complete the first-run setup — the **first registered user becomes the admin**. Set
`root_url` so clone URLs and links are right. Uses SQLite (great for small teams; switch to PostgreSQL via
`FORGEJO__database__*` env for larger ones). Serves plain HTTP — front it with a reverse proxy for TLS. Pin
the job to the node holding the volume with `constraints`.
