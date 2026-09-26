# dumbassets

[DumbAssets](https://github.com/DumbWareio/DumbAssets) — a simple **home asset and warranty tracker**. Record your
belongings with photos, serial numbers, purchase dates, prices and warranty expiries, organize them with components
and tags, and get reminders before warranties run out. No database — everything is stored as JSON on disk.

Single host-networked Nomad service with a persistent data volume.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run dumbassets --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `3000` | Web UI port (`PORT`). |
| `pin` | `""` | Optional PIN, 4+ digits (`DUMBASSETS_PIN`). Empty = no auth. |
| `base_url` | `""` | Public URL (`BASE_URL`). Empty = `http://localhost:<port>`. |
| `image` | `dumbwareio/dumbassets:latest` | Container image. Pin a tag in production. |
| `data_volume` | `dumbassets_data` | `/app/data` — asset records (JSON). |
| `resources` | `{ cpu = 300, memory = 256 }` | Task resources. |

> Set a `pin` (or put it behind an authenticating reverse proxy) before exposing it. A prestart init task chowns the
> data volume to uid `1000`. Pairs well with [homebox](https://packs.nomploy.com/packs/homebox) for broader home
> inventory. Pin the job to the node holding the volume with `constraints`.
