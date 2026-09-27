# posterr

[Posterr](https://github.com/petersem/posterr) — a **digital-signage dashboard** for your media server. Display
now-playing, recently-added and on-demand posters from Plex, Jellyfin and the *arr apps on a spare screen or TV — a nice
"coming soon" board for your home cinema.

Single host-networked Nomad service with config and custom-media volumes.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run posterr --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `3000` | Web UI port. |
| `image` | `petersem/posterr:latest` | Container image. Pin a tag in production. |
| `data_volume` | `posterr_data` | `/usr/src/app/config` — settings. |
| `custom_volume` | `posterr_custom` | `/usr/src/app/public/custom` — custom images/media. |
| `tz` | `UTC` | Container timezone (`TZ`). |
| `resources` | `{ cpu = 300, memory = 256 }` | Task resources. |

> Open the admin (default password `raidisnotabackup` — change it) and connect your Plex/Jellyfin/Sonarr/Radarr servers.
> A prestart init task makes the volumes writable. Point a browser or kiosk display at it. Pin the job to the node
> holding the volumes with `constraints`.
