# mylar3

[Mylar3](https://github.com/mylar3/mylar3) — an automated **comic-book (cbr/cbz) downloader** and library manager.
Track series and pull-lists, search NZB indexers and torrent trackers, grab issues as they release, and organize
them into a clean library ready for a reader like Komga, Kavita or Stump.

Single host-networked Nomad service with config, library and downloads volumes.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run mylar3 --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `8090` | Web UI port. |
| `image` | `lscr.io/linuxserver/mylar3:latest` | Container image. Pin a tag in production. |
| `data_volume` | `mylar3_data` | `/config` — settings and database. |
| `comics_volume` | `mylar3_comics` | `/comics` — the managed comic library. |
| `downloads_volume` | `mylar3_downloads` | `/downloads` — where the download client drops files to import. |
| `puid` / `pgid` | `1000` / `1000` | User/group that owns the files (`PUID`/`PGID`). |
| `tz` | `UTC` | Container timezone (`TZ`). |
| `resources` | `{ cpu = 300, memory = 256 }` | Task resources. |

> **Pairs with** a download client ([sabnzbd](https://packs.nomploy.com/packs/sabnzbd),
> [qbittorrent](https://packs.nomploy.com/packs/qbittorrent)), an indexer manager
> ([prowlarr](https://packs.nomploy.com/packs/prowlarr)) and a reader
> ([komga](https://packs.nomploy.com/packs/komga) / [kavita](https://packs.nomploy.com/packs/kavita)). For imports to
> work, Mylar3 and the download client should share the same `/downloads` path. Pin the job to the node holding the
> volumes with `constraints`.
