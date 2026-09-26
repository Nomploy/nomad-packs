# thelounge

[The Lounge](https://thelounge.chat/) — a modern, self-hosted **web IRC client**. It stays connected to IRC networks on
your server (so you never miss messages), syncs across all your devices, and offers a clean, responsive UI with push
notifications, link previews and multiple users.

Single host-networked Nomad service with a persistent config volume.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run thelounge --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `9000` | Web UI port. |
| `image` | `lscr.io/linuxserver/thelounge:latest` | Container image. Pin a tag in production. |
| `data_volume` | `thelounge_data` | `/config` — users, logs and settings. |
| `puid` / `pgid` | `1000` / `1000` | User/group that owns the files (`PUID`/`PGID`). |
| `tz` | `UTC` | Container timezone (`TZ`). |
| `resources` | `{ cpu = 300, memory = 256 }` | Task resources. |

> Create a user from the container to log in, e.g. `thelounge add <name>` (exec into the task), or enable public mode
> in the config. Put it behind an authenticating reverse proxy over TLS if exposed. Pin the job to the node holding the
> volume with `constraints`.
