# karma

[Karma](https://github.com/prymitive/karma) — a dashboard for **Prometheus Alertmanager**. It aggregates alerts from
one or many Alertmanager instances, groups and deduplicates them, shows rich labels and annotations, and lets you
create and manage silences from a clean, auto-refreshing UI — a much nicer view than Alertmanager's built-in page.

Single **stateless** host-networked Nomad service (no volume).

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run karma --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `8080` | Web UI port (`PORT`). |
| `alertmanager_uri` | `http://127.0.0.1:9093` | Alertmanager URL to display (`ALERTMANAGER_URI`). |
| `image` | `ghcr.io/prymitive/karma:latest` | Container image. Pin a tag in production. |
| `resources` | `{ cpu = 300, memory = 256 }` | Task resources. |

> **Pairs with** [alertmanager](https://packs.nomploy.com/packs/alertmanager) and
> [monitoring](https://packs.nomploy.com/packs/monitoring). For multiple Alertmanagers or advanced options (auth,
> label rules), mount a `karma.yaml` and pass `CONFIG_FILE`. Being stateless, it needs no storage and can run
> anywhere it can reach your Alertmanager.
