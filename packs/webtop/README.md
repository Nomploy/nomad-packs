# webtop

[Webtop](https://docs.linuxserver.io/images/docker-webtop/) — a full **Linux desktop** environment in a container,
streamed to your browser (no VNC client needed). Choose XFCE, KDE, MATE, i3 and more via the image tag. Great as a
disposable workstation, a jump box, or a place to run GUI apps on your server.

Single host-networked Nomad service with a persistent home volume.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run webtop --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `3000` | Web desktop port (`CUSTOM_PORT`). |
| `image` | `lscr.io/linuxserver/webtop:ubuntu-xfce` | Flavor tag (e.g. `alpine-kde`, `debian-mate`, `fedora-i3`). Pin in production. |
| `shm_size` | `1073741824` (1 GB) | Shared memory — browsers/apps in the desktop need a large `/dev/shm`. |
| `config_volume` | `webtop_config` | `/config` — the desktop home directory. |
| `puid` / `pgid` | `1000` / `1000` | User/group (`PUID`/`PGID`). |
| `tz` | `UTC` | Container timezone (`TZ`). |
| `resources` | `{ cpu = 2000, memory = 2048 }` | Task resources. A desktop needs generous CPU/RAM. |

> **Security:** Webtop gives full shell + GUI access to a container on your host. **Never** expose it to the
> internet without an authenticating reverse proxy over TLS — treat it like remote root access. Pin the job to the
> node holding the volume with `constraints`.
