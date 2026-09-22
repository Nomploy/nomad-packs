# trilium

[Trilium Notes (TriliumNext)](https://github.com/TriliumNext/Trilium) — a hierarchical
note-taking and personal knowledge-base application with rich text, code notes, scripting,
relations, and fast full-text search.

Single host-networked Nomad service backed by SQLite. A busybox prestart task chowns the data
volume to the configured UID/GID (Trilium runs as uid 1000).

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run trilium --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `8102` | Web UI port (`TRILIUM_PORT`). |
| `uid` / `gid` | `1000` / `1000` | User Trilium runs as (`USER_UID`/`USER_GID`); volume is chown'd to it. |
| `data_volume` | `trilium_data` | `/home/node/trilium-data` — database, config, attachments. |
| `image` | `triliumnext/trilium:latest` | Container image. Pin a tag in production. |
| `resources` | `{ cpu = 500, memory = 256 }` | Task resources. |

Set a password on first visit (it protects the whole instance). Pin the job to the node holding
`data_volume` with `constraints`.
