# focalboard

[Focalboard](https://www.focalboard.com) — a self-hosted **project management** tool for boards, tasks, and
notes. Organize work as **kanban, table, gallery, or calendar** views — a Trello / Notion-boards alternative you
host yourself.

Single host-networked Nomad service with a persistent data volume (SQLite).

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run focalboard --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `8000` | Web UI port. The container listens on 8000. |
| `data_volume` | `focalboard_data` | `/opt/focalboard/data` — SQLite DB, files, and config. |
| `image` | `mattermost/focalboard:latest` | Container image. Pin a tag in production. |
| `resources` | `{ cpu = 300, memory = 256 }` | Task resources. |

Register an account on first visit, then create boards. This is the standalone "personal server" edition using
SQLite — to change the listen port, edit `config.json` in the data volume. Serves plain HTTP — front it with a
reverse proxy for TLS. Pin the job to the node holding the volume with `constraints`.
