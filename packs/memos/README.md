# memos

[Memos](https://www.usememos.com) — a lightweight, privacy-first note-taking / knowledge base for
quick memos with Markdown, tags, and public/private sharing.

Single host-networked Nomad service on SQLite with a persistent data volume.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run memos --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `5230` | Web UI port (`MEMOS_PORT`). |
| `data_volume` | `memos_data` | `/var/opt/memos` — SQLite database + uploads. |
| `image` | `ghcr.io/usememos/memos:stable` | Container image. Pin a tag in production. |
| `resources` | `{ cpu = 300, memory = 128 }` | Task resources. |

The first account created becomes the admin. Pin the job to the node holding the volume with
`constraints`.
