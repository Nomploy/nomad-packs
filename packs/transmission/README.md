# transmission

[Transmission](https://transmissionbt.com/) — a lightweight, no-nonsense **BitTorrent client** with a clean web UI and
a well-supported RPC API. A great download client for the *arr stack (Sonarr/Radarr/Prowlarr) or standalone.

Single host-networked Nomad service with config, downloads and watch volumes.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run transmission --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `9091` | Web UI / RPC port. |
| `peer_port` | `51413` | BitTorrent peer port (TCP + UDP). Forward it on your router for good connectivity. |
| `image` | `lscr.io/linuxserver/transmission:latest` | Container image. Pin a tag in production. |
| `data_volume` | `transmission_data` | `/config` — settings and resume data. |
| `downloads_volume` | `transmission_downloads` | `/downloads` — your downloads. |
| `watch_volume` | `transmission_watch` | `/watch` — drop `.torrent` files here to auto-add. |
| `puid` / `pgid` | `1000` / `1000` | User/group that owns the files (`PUID`/`PGID`). |
| `tz` | `UTC` | Container timezone (`TZ`). |
| `resources` | `{ cpu = 300, memory = 256 }` | Task resources. |

> **Pairs with** [prowlarr](https://packs.nomploy.com/packs/prowlarr),
> [sonarr](https://packs.nomploy.com/packs/sonarr) and [radarr](https://packs.nomploy.com/packs/radarr) — share the
> `/downloads` path so they can import completed files. The web UI has no auth by default; set credentials in
> Transmission's settings or put it behind an authenticating reverse proxy. Pin the job to the node holding the
> volumes with `constraints`.
