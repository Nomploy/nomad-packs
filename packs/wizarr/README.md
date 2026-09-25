# wizarr

[Wizarr](https://github.com/Wizarrrr/wizarr) — a user **invitation and onboarding portal** for Jellyfin, Plex and
Emby. Instead of manually creating accounts, you share a Wizarr invite link: new users sign up, Wizarr provisions
their media-server account (with the right libraries), and walks them through installing an app and requesting media.

Single host-networked Nomad service with a persistent database volume.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run wizarr --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `5690` | Web UI port. |
| `image` | `ghcr.io/wizarrrr/wizarr:latest` | Container image. Pin a tag in production. |
| `data_volume` | `wizarr_data` | `/data/database` — settings and the SQLite database. |
| `tz` | `UTC` | Container timezone (`TZ`). |
| `resources` | `{ cpu = 300, memory = 256 }` | Task resources. |

> On first launch, complete the setup wizard: connect your media server
> ([jellyfin](https://packs.nomploy.com/packs/jellyfin) / Plex / Emby) and create your admin account. Pairs naturally
> with [jellyseerr](https://packs.nomploy.com/packs/jellyseerr) / [ombi](https://packs.nomploy.com/packs/ombi) for
> requests. Pin the job to the node holding the volume with `constraints`.
