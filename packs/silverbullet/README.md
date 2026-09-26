# silverbullet

[SilverBullet](https://silverbullet.md/) — an extensible, **Markdown-based personal knowledge management** and
note-taking web app. Notes are plain `.md` files in a "space", with wiki-links, live templates, queries over your
notes, and a plug ecosystem. It's a fast PWA that works offline and syncs when you're back online.

Single host-networked Nomad service with a persistent space volume.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run silverbullet --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `3000` | Web UI port (`SB_PORT`). |
| `auth` | `""` | Optional built-in auth as `user:password` (`SB_USER`). Empty = no auth. |
| `image` | `ghcr.io/silverbulletmd/silverbullet:latest` | Container image. Pin a tag in production. |
| `data_volume` | `silverbullet_data` | `/data` — your Markdown space (`SB_FOLDER`). |
| `resources` | `{ cpu = 300, memory = 256 }` | Task resources. |

> **Set `auth` (or a proxy) before exposing it** — with no `SB_USER` the space is open to anyone who can reach the
> port. Because your notes live on the volume, pin the job to the node holding it with `constraints`. Everything is
> plain Markdown, so back up the volume (or point it at a synced folder) and you can read your notes with any editor.
