# opengist

[Opengist](https://opengist.io) — a self-hosted pastebin powered by Git, an open-source alternative
to GitHub Gist: share snippets with syntax highlighting, revisions, visibility controls, and embeds.

Single host-networked Nomad service on SQLite with a data volume. A busybox prestart task chowns the
data volume to Opengist's UID.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run opengist --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `6157` | Web UI port (`OG_HTTP_PORT`). |
| `uid` | `1000` | User Opengist runs as; data volume is chown'd to it. |
| `data_volume` | `opengist_data` | `/opengist` — SQLite database + Git repos. |
| `image` | `ghcr.io/thomiceli/opengist:1` | Image. Pin a tag in production. |
| `resources` | `{ cpu = 300, memory = 256 }` | Task resources. |

The first registered user becomes admin. Git-over-SSH is off by default (HTTP only) — enable it with
`OG_SSH_GIT_ENABLED` + an SSH port if you need git push/pull. Pin the job to the node holding the
volume with `constraints`.
