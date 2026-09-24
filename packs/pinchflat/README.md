# pinchflat

[Pinchflat](https://github.com/kieraneglin/pinchflat) — a self-hosted **YouTube media manager**. Subscribe to
channels or playlists and it automatically downloads new videos with [yt-dlp](https://github.com/yt-dlp/yt-dlp),
names and organizes them for your media server, and can expose podcast-style RSS feeds. Set-and-forget
archiving, unlike the manual `metube` pack.

Single host-networked Nomad service using **SQLite** with config and downloads volumes.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run pinchflat --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `8945` | Web UI port (`PORT`). |
| `tz` | `UTC` | Container timezone (`TZ`). |
| `basic_auth_username` / `basic_auth_password` | `""` | Optional HTTP basic auth. Empty = no login. |
| `config_volume` | `pinchflat_config` | `/config` — SQLite DB and settings. |
| `downloads_volume` | `pinchflat_downloads` | `/downloads` — the media files. |
| `image` | `ghcr.io/kieraneglin/pinchflat:latest` | Container image. Pin a tag in production. |
| `resources` | `{ cpu = 500, memory = 512 }` | Task resources. |

Add a source (channel/playlist), set download options, and Pinchflat handles the rest on a schedule. Point a
media pack (`jellyfin`, `navidrome`) at the downloads volume. **No auth by default** — set the basic-auth vars
or keep it internal, and only download content you have the rights to. Pin the job to the node holding the
volumes with `constraints`.
