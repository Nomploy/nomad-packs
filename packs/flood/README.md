# flood

[Flood](https://github.com/jesec/flood) — a modern, responsive **web UI for your torrent client**. Point it at
Transmission, qBittorrent, Deluge or rTorrent and get a clean dashboard with labels, feeds, per-torrent details and
multi-user support — a nicer front-end than the clients' built-in UIs.

Single host-networked Nomad service with a persistent data volume.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run flood --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `3000` | Web UI port (`FLOOD_OPTION_port`). |
| `image` | `jesec/flood:latest` | Container image. Pin a tag in production. |
| `data_volume` | `flood_data` | `/data` — users and settings. |
| `resources` | `{ cpu = 300, memory = 256 }` | Task resources. |

> **Needs a torrent client:** connect Flood to a running client from its web UI on first login (e.g.
> [transmission](https://packs.nomploy.com/packs/transmission), [qbittorrent](https://packs.nomploy.com/packs/qbittorrent)
> or [deluge](https://packs.nomploy.com/packs/deluge)). Flood does file operations itself, so it must see the same
> download paths as the client — run them on the same node and share the downloads volume. A prestart init task chowns
> the data volume to uid `1000`. Pin the job with `constraints`.
