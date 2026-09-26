# calibre

[Calibre](https://calibre-ebook.com/) — the full **e-book management desktop**, streamed to your browser. Import and
convert books between formats, edit metadata and covers, fetch news, and manage your library — then serve it over the
network with Calibre's built-in **content server**. Pairs perfectly with
[calibre-web](https://packs.nomploy.com/packs/calibre-web) for a lightweight reading front-end on the same library.

Single host-networked Nomad service (a browser-streamed desktop) with a persistent library volume.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run calibre --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `8080` | Desktop GUI port (browser-streamed). |
| `content_port` | `8081` | Calibre content-server port (enable it in Calibre → Preferences → Sharing over the net). |
| `password` | `""` | Optional GUI password (`PASSWORD`). |
| `image` | `lscr.io/linuxserver/calibre:latest` | Container image. Pin a tag in production. |
| `data_volume` | `calibre_data` | `/config` — settings and your library. |
| `puid` / `pgid` | `1000` / `1000` | User/group that owns the files (`PUID`/`PGID`). |
| `tz` | `UTC` | Container timezone (`TZ`). |
| `shm_size` | `1073741824` (1 GB) | Shared memory for the streamed desktop. |
| `resources` | `{ cpu = 2000, memory = 2048 }` | Task resources. A GUI desktop needs generous CPU/RAM. |

> **Security:** the desktop gives full app access on your host — set a `password` and/or put it behind an
> authenticating reverse proxy over TLS; never expose it raw. It runs with `seccomp=unconfined` (required by the
> streamed desktop). To share the library with calibre-web, point both at the same library path and pin both jobs to
> the node holding this volume with `constraints`.
