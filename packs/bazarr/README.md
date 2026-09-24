# bazarr

[Bazarr](https://www.bazarr.media) — a companion to **Sonarr** and **Radarr** that automatically downloads and
manages **subtitles** for your shows and movies, in the languages you choose, from a wide range of providers.

Single host-networked Nomad service with config and media volumes.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run bazarr --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `6767` | Web UI port. |
| `config_volume` | `bazarr_config` | `/config` — database and settings. |
| `data_volume` | `media_data` | `/data` — the media library (**share with sonarr/radarr**). |
| `puid` / `pgid` | `1000` / `1000` | User/group (`PUID`/`PGID`). |
| `tz` | `UTC` | Container timezone (`TZ`). |
| `image` | `lscr.io/linuxserver/bazarr:latest` | Container image. Pin a tag in production. |
| `resources` | `{ cpu = 300, memory = 256 }` | Task resources. |

Point Bazarr at the `sonarr` / `radarr` packs (co-located on `127.0.0.1`), choose subtitle languages and
providers, and it handles the rest. Use the **same `/data` volume** as those apps so paths match. For providers
behind Cloudflare, add the `flaresolverr` pack. Serves plain HTTP — front it with a reverse proxy for TLS.
