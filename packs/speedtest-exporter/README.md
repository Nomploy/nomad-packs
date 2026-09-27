# speedtest-exporter

[Speedtest Exporter](https://github.com/MiguelNdeCarvalho/speedtest-exporter) — runs internet **speed tests** (via the
official Ookla CLI) and exposes the results — download, upload, ping, jitter — as **Prometheus metrics**. Scrape it on a
schedule to graph your connection over time in Grafana.

Single **stateless** host-networked Nomad service (no volume).

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run speedtest-exporter --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `9798` | Metrics port (`SPEEDTEST_PORT`); metrics at `/metrics`. |
| `image` | `ghcr.io/miguelndecarvalho/speedtest-exporter:latest` | Container image. Pin a tag in production. |
| `resources` | `{ cpu = 300, memory = 256 }` | Task resources. |

> A speed test takes ~30s, so scrape it **infrequently** (e.g. every 15–60 min) — add a Prometheus job with a long
> `scrape_interval` and `scrape_timeout: 60s` pointing at `<host>:9798/metrics`. Pairs with
> [monitoring](https://packs.nomploy.com/packs/monitoring) and [grafana](https://packs.nomploy.com/packs/grafana).
