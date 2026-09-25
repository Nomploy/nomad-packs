# slash

[Slash](https://github.com/yourselfhosted/slash) — a self-hosted **link shortener and bookmark hub**. Create memorable
short links (`s/my-link`) and organize shared bookmarks into collections, with visit analytics, access control and a
browser extension. A tidy replacement for Bitly plus a team start page.

Single host-networked Nomad service with a persistent SQLite volume.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run slash --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `5231` | Web UI port. |
| `image` | `yourselfhosted/slash:latest` | Container image. Pin a tag in production. |
| `data_volume` | `slash_data` | `/var/opt/slash` — the SQLite database. |
| `resources` | `{ cpu = 300, memory = 256 }` | Task resources. |

> The first account you create becomes the admin. Pin the job to the node holding the volume with `constraints`, and
> put Slash behind a reverse proxy for a clean short-link domain.
