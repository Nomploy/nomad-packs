# deluge

[Deluge](https://deluge-torrent.org/) — a lightweight, full-featured **BitTorrent client** with a web UI, a daemon for
thin-client access, and a rich plugin system (labels, scheduler, auto-add and more). A solid download client for the
*arr stack or standalone use.

Single host-networked Nomad service with config and downloads volumes.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run deluge --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `8112` | Web UI port. |
| `peer_port` | `6881` | BitTorrent peer port (TCP + UDP). Forward it on your router. |
| `daemon_port` | `58846` | Deluge daemon (RPC) port for thin clients. |
| `image` | `lscr.io/linuxserver/deluge:latest` | Container image. Pin a tag in production. |
| `data_volume` | `deluge_data` | `/config` — settings and state. |
| `downloads_volume` | `deluge_downloads` | `/downloads` — your downloads. |
| `puid` / `pgid` | `1000` / `1000` | User/group that owns the files (`PUID`/`PGID`). |
| `tz` | `UTC` | Container timezone (`TZ`). |
| `resources` | `{ cpu = 300, memory = 256 }` | Task resources. |

> Default web UI password is `deluge` — change it on first login. **Pairs with**
> [prowlarr](https://packs.nomploy.com/packs/prowlarr) and the *arr apps; share the `/downloads` path so they can
> import. Pin the job to the node holding the volumes with `constraints`.
