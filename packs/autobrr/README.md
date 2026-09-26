# autobrr

[autobrr](https://autobrr.com/) — a modern **download automation** tool. It watches tracker IRC announce channels and
RSS in real time, applies powerful filters (resolution, release group, size, freeleech and much more), and instantly
pushes matches to your download client and the *arr apps — far faster and more precise than RSS polling alone.

Single host-networked Nomad service with a persistent config volume (SQLite).

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run autobrr --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `7474` | Web UI port (`AUTOBRR__PORT`). |
| `image` | `ghcr.io/autobrr/autobrr:latest` | Container image. Pin a tag in production. |
| `data_volume` | `autobrr_data` | `/config` — SQLite database and config. |
| `tz` | `UTC` | Container timezone (`TZ`). |
| `resources` | `{ cpu = 300, memory = 256 }` | Task resources. |

> The pack sets `AUTOBRR__HOST=0.0.0.0` so the UI is reachable (autobrr defaults to loopback-only). A prestart init
> task chowns the config volume to uid `1000`. **Pairs with** [prowlarr](https://packs.nomploy.com/packs/prowlarr),
> [sonarr](https://packs.nomploy.com/packs/sonarr)/[radarr](https://packs.nomploy.com/packs/radarr) and a client like
> [qbittorrent](https://packs.nomploy.com/packs/qbittorrent). Pin the job to the node holding the volume with
> `constraints`.
