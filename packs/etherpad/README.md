# etherpad

[Etherpad](https://etherpad.org/) — a real-time **collaborative document editor**. Several people edit the same rich-text
pad together live, with colored authorship, chat, revision history and a huge plugin ecosystem. Share a pad URL and
start writing together — no accounts needed.

Single host-networked Nomad service using **SQLite** on a persistent volume.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run etherpad --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `9001` | Web UI port. Fixed at `9001` inside the image. |
| `admin_password` | `""` | Password for the `/admin` settings UI (`ADMIN_PASSWORD`, user `admin`). Empty = admin UI off. |
| `image` | `etherpad/etherpad:latest` | Container image. Pin a tag in production. |
| `data_volume` | `etherpad_data` | `/opt/etherpad-lite/var` — the SQLite database and uploads. |
| `resources` | `{ cpu = 300, memory = 256 }` | Task resources. |

> A prestart init task chowns the data volume to uid `5001` (Etherpad runs unprivileged). Set `admin_password` to
> manage plugins and settings at `/admin`. For a large multi-user instance, switch to an external PostgreSQL/MySQL via
> the `DB_*` env vars. Pin the job to the node holding the volume with `constraints`.
