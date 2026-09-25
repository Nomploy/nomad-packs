# kapowarr

[Kapowarr](https://github.com/Casvt/Kapowarr) — an automated **comic-book library manager and downloader**, in the
spirit of Sonarr/Radarr but for comics. Build a volume/issue library, match against ComicVine, grab issues from your
download clients, then rename and organize them into a clean folder structure ready for a reader.

Single host-networked Nomad service with database, downloads and library volumes.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run kapowarr --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `5656` | Web UI port. |
| `image` | `mrcas/kapowarr:latest` | Container image. Pin a tag in production. |
| `data_volume` | `kapowarr_data` | `/app/db` — the SQLite database. |
| `downloads_volume` | `kapowarr_downloads` | `/app/temp_downloads` — in-progress downloads. |
| `comics_volume` | `kapowarr_comics` | `/comics` — the managed comic library (root folder). |
| `puid` / `pgid` | `1000` / `1000` | User/group that owns the files (`PUID`/`PGID`). |
| `tz` | `UTC` | Container timezone (`TZ`). |
| `resources` | `{ cpu = 300, memory = 256 }` | Task resources. |

> Set `/comics` as your root folder in Settings, and give Kapowarr a ComicVine API key to enable searching. Reads
> beautifully in [komga](https://packs.nomploy.com/packs/komga) or [kavita](https://packs.nomploy.com/packs/kavita).
> Pin the job to the node holding the volumes with `constraints`.
