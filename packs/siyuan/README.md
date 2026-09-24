# siyuan

[SiYuan](https://b3log.org/siyuan/en/) — a privacy-first, self-hosted personal knowledge base built around
Markdown **blocks**. Outline and nest everything, backlink and transclude notes, build databases and
flashcards, and keep it all in **plain local files** — a powerful, offline-capable Notion alternative.

Single host-networked Nomad service with a persistent workspace volume. A prestart task chowns the volume
so the SiYuan user (uid/gid 1000) can write it.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run siyuan --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `6806` | Web UI port. The container listens on 6806. |
| `access_auth_code` | `change-me-please` | Lock-screen password (`--accessAuthCode`). **Change it** — it's the only gate on your notes. |
| `workspace_volume` | `siyuan_workspace` | `/siyuan/workspace` — all notes, assets, settings. |
| `image` | `b3log/siyuan:latest` | Container image. Pin a tag in production. |
| `resources` | `{ cpu = 500, memory = 512 }` | Task resources. |

Open the URL and unlock with your access code; notes are stored as Markdown + JSON in the workspace volume,
so they're easy to back up and portable. The SiYuan desktop/mobile apps can sync to this server. Serves
plain HTTP — front it with a reverse proxy for TLS. Pin the job to the node holding the volume with
`constraints`.
