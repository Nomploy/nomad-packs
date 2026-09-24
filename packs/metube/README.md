# metube

[MeTube](https://github.com/alexta69/metube) — a clean, self-hosted web UI for
[yt-dlp](https://github.com/yt-dlp/yt-dlp). Paste a video or playlist URL, choose the format and quality,
and it downloads straight to your server — great for archiving talks, music, and playlists to your own
storage.

Single host-networked Nomad service with a downloads volume.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run metube --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `8081` | Web UI port (`PORT`). |
| `downloads_volume` | `metube_downloads` | `/downloads` — where files are saved. |
| `uid` / `gid` | `1000` / `1000` | Ownership of downloaded files (`UID`/`GID`). |
| `image` | `ghcr.io/alexta69/metube:latest` | Container image. Pin a tag in production. |
| `resources` | `{ cpu = 500, memory = 256 }` | Task resources. |

Paste a URL and download; files land in the `downloads_volume` (point a media pack like `jellyfin` or
`navidrome` at them). MeTube has **no authentication** — keep it internal or behind an authenticating reverse
proxy, and only download content you have the rights to. Pin the job to the node holding the volume with
`constraints`.
