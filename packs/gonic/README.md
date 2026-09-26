# gonic

[gonic](https://github.com/sentriz/gonic) — a lightweight, fast **Subsonic / OpenSubsonic** music streaming server.
Point any Subsonic-compatible app (DSub, Symfonium, play:Sub, Feishin, …) at it to stream your library, with multi-user
support, podcasts, playlists, scrobbling and on-the-fly transcoding — all from a tiny Go binary.

Single host-networked Nomad service with library, database, podcasts and playlists volumes.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run gonic --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `4747` | Web UI / Subsonic API port (`GONIC_LISTEN_ADDR`). |
| `image` | `sentriz/gonic:latest` | Container image. Pin a tag in production. |
| `data_volume` | `gonic_data` | `/data` — database and caches. |
| `music_volume` | `gonic_music` | `/music` — your music library. |
| `podcasts_volume` | `gonic_podcasts` | `/podcasts` — downloaded podcasts. |
| `playlists_volume` | `gonic_playlists` | `/playlists` — M3U playlists. |
| `resources` | `{ cpu = 300, memory = 256 }` | Task resources. |

> Default login is `admin` / `admin` — change it on first visit. Put your music under the `music_volume` (or point it at
> an existing library). A prestart init task makes the writable volumes accessible. Pin the job to the node holding the
> volumes with `constraints`. A lighter alternative to [navidrome](https://packs.nomploy.com/packs/navidrome).
