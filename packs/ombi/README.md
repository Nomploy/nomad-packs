# ombi

[Ombi](https://ombi.io/) — a self-hosted **media request portal**. Your users browse and request movies and TV
shows; Ombi handles approvals and hands the request off to Sonarr/Radarr for downloading, then notifies people when
their media is ready. It plugs into Plex, Jellyfin and Emby for user accounts and library awareness.

Single host-networked Nomad service with a persistent config volume.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run ombi --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `3579` | Web UI port. Fixed inside the LinuxServer image — keep it reachable on `3579`. |
| `image` | `lscr.io/linuxserver/ombi:latest` | Container image. Pin a tag in production. |
| `data_volume` | `ombi_data` | `/config` — settings and database. |
| `puid` / `pgid` | `1000` / `1000` | User/group that owns the files (`PUID`/`PGID`). |
| `tz` | `UTC` | Container timezone (`TZ`). |
| `base_url` | `""` | Optional subfolder path behind a reverse proxy (`BASE_URL`), e.g. `/ombi`. |
| `resources` | `{ cpu = 300, memory = 256 }` | Task resources. |

> **Pairs with** [sonarr](https://packs.nomploy.com/packs/sonarr), [radarr](https://packs.nomploy.com/packs/radarr),
> [prowlarr](https://packs.nomploy.com/packs/prowlarr) and [jellyfin](https://packs.nomploy.com/packs/jellyfin).
> Pin the job to the node holding the volume with `constraints`.
