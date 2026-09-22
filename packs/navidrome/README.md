# navidrome

[Navidrome](https://www.navidrome.org) — a self-hosted music streaming server with a web
player and a Subsonic / OpenSubsonic API, so you can stream your own library to phones and
desktop apps.

Single host-networked Nomad service. Runs as root so the fresh named volumes are writable
out of the box.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run navidrome --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `4533` | Web UI / Subsonic API port (`ND_PORT`). |
| `data_volume` | `navidrome_data` | `/data` — database, cache, cover art. |
| `music_volume` | `navidrome_music` | `/music`, mounted read-only — your library. |
| `image` | `deluan/navidrome:latest` | Container image. Pin a tag in production. |
| `resources` | `{ cpu = 500, memory = 256 }` | Task resources. |

Create the admin account on first visit. The music volume starts empty — fill it (a host
copy, the [syncthing](../syncthing) pack, etc.) and scan from **Settings**. Pin the job to the
node that holds the volumes with `constraints`.
