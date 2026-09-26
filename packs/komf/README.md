# komf

[Komf](https://github.com/Snd-R/komf) — a **metadata fetcher and manager** for [Komga](https://packs.nomploy.com/packs/komga)
and [Kavita](https://packs.nomploy.com/packs/kavita). It pulls series and book metadata plus covers from providers
(AniList, MangaUpdates, MAL, Comic Vine and more) and writes them back to your library, and can auto-run on new
additions via webhooks. Includes a small web UI.

Single host-networked Nomad service with a persistent config volume.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run komf --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `8085` | Web UI port. |
| `komga_url` | `""` | Optional Komga base URL (`KOMF_KOMGA_BASE_URI`), e.g. `http://127.0.0.1:25600`. |
| `kavita_url` | `""` | Optional Kavita base URL (`KOMF_KAVITA_BASE_URI`), e.g. `http://127.0.0.1:5000`. |
| `image` | `sndxr/komf:latest` | Container image. Pin a tag in production. |
| `data_volume` | `komf_data` | `/config` — `application.yml` and the state database. |
| `resources` | `{ cpu = 300, memory = 256 }` | Task resources. |

> Point `komga_url`/`kavita_url` at your library server (run them on the same node so loopback works), then set
> credentials and providers in `application.yml` or the web UI. A prestart init task chowns the config volume to uid
> `1000`. Pin the job to the node holding the volume with `constraints`.
