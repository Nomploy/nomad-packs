# mafl

[Mafl](https://github.com/hywax/mafl) — a minimalist, self-hosted **start page / dashboard** configured with a single
`config.yml`. Group links into sections, show live service status checks, and add small widgets — a clean home page for
your homelab without a heavy admin UI.

Single host-networked Nomad service with a persistent config volume.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run mafl --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `3000` | Web UI port (`PORT`). |
| `image` | `ghcr.io/hywax/mafl:latest` | Container image. Pin a tag in production. |
| `data_volume` | `mafl_data` | `/app/data` — holds `config.yml`. |
| `resources` | `{ cpu = 300, memory = 256 }` | Task resources. |

> Mafl writes a starter `config.yml` into the volume on first run — edit it to define your sections, links and checks. A
> prestart init task makes the data volume writable. Pin the job to the node holding the volume with `constraints`.
