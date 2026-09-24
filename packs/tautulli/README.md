# tautulli

[Tautulli](https://tautulli.com) — a monitoring and analytics dashboard for your **Plex Media Server**. See what's
being watched and by whom, full stream history, per-user and per-library stats, and get rich notifications for
activity and new content.

Single host-networked Nomad service with a persistent config volume.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run tautulli --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `8181` | Web UI port. |
| `config_volume` | `tautulli_config` | `/config` — SQLite database and settings. |
| `puid` / `pgid` | `1000` / `1000` | User/group (`PUID`/`PGID`). |
| `tz` | `UTC` | Container timezone (`TZ`). |
| `image` | `lscr.io/linuxserver/tautulli:latest` | Container image. Pin a tag in production. |
| `resources` | `{ cpu = 300, memory = 256 }` | Task resources. |

On first run, connect Tautulli to your Plex server (server URL + token). It then records watch history and builds
stats. **Requires a Plex Media Server to monitor.** Serves plain HTTP — front it with a reverse proxy for TLS. Pin
the job to the node holding the volume with `constraints`.
