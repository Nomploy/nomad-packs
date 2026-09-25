# dashy

[Dashy](https://github.com/Lissy93/dashy) — a feature-rich **homelab startpage** and dashboard. Group your
services into sections, show live status checks and health, pull data with widgets (weather, RSS, system stats,
container status and dozens more), and restyle it all with built-in themes. Configuration is a single `conf.yml`
that you can edit by hand or through the built-in visual editor.

Single host-networked Nomad service with a persistent config volume.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run dashy --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `8080` | Web UI port (`PORT`). |
| `image` | `lissy93/dashy:latest` | Container image. Pin a tag in production. |
| `data_volume` | `dashy_data` | `/app/user-data` — holds `conf.yml` and custom assets. |
| `resources` | `{ cpu = 300, memory = 256 }` | Task resources. |

> **First run:** Dashy starts with an example dashboard. Edit `conf.yml` in the `data_volume` (or use the web
> editor, then export) to define your own sections and items. Changes are picked up on save/rebuild. Pin the job to
> the node holding the volume with `constraints`.
