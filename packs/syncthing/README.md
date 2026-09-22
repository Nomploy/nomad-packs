# syncthing

[Syncthing](https://syncthing.net) — continuous, peer-to-peer file synchronization between your
devices. No central server, end-to-end TLS, open source.

Single host-networked Nomad service (the official `syncthing/syncthing` image). A busybox
prestart task chowns the data volume to the configured UID/GID (Syncthing runs as uid 1000 by
default), and the GUI is bound on all interfaces so it's reachable through host networking.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run syncthing --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `gui_port` | `8384` | Web GUI port (`STGUIADDRESS`). |
| `sync_port` | `22000` | Device-to-device sync (TCP + QUIC/UDP). |
| `uid` / `gid` | `1000` / `1000` | User Syncthing runs as (`PUID`/`PGID`); volume is chown'd to it. |
| `data_volume` | `syncthing_data` | `/var/syncthing` — config, keys, default folder. |
| `image` | `syncthing/syncthing:latest` | Container image. Pin a tag in production. |
| `resources` | `{ cpu = 500, memory = 256 }` | Task resources. |

## Security

The GUI is exposed on all interfaces — **set a GUI username/password immediately** (Actions →
Settings) and put TLS in front of it. Local discovery also uses UDP `21027`; for remote peers
behind NAT, forward `sync_port` (TCP/UDP) or rely on Syncthing's relays.

Pin the job to the node holding `data_volume` with `constraints`.
