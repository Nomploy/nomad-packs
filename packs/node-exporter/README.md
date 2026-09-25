# node-exporter

[Prometheus Node Exporter](https://github.com/prometheus/node_exporter) — exposes a machine's hardware and OS
metrics (CPU, memory, disk I/O, filesystem, network, load, temperatures) on a `/metrics` endpoint for Prometheus
to scrape. The standard way to monitor a Linux host.

Single host-networked Nomad service that reads the host read-only.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run node-exporter --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `9100` | Metrics port (`--web.listen-address`). |
| `image` | `quay.io/prometheus/node-exporter:latest` | Container image. Pin a tag in production. |
| `resources` | `{ cpu = 100, memory = 64 }` | Task resources. |

Add a scrape target `http://<node-ip>:9100/metrics` in Prometheus (the `monitoring` pack) and import a Node
Exporter dashboard in Grafana. The job bind-mounts `/` at `/host` (read-only) with `--path.rootfs=/host` and uses
the host PID namespace for accurate metrics. Run **one instance per node** (pin with `constraints`). The endpoint
is unauthenticated — keep it on an internal network.

> Note: the `monitoring` pack already bundles node-exporter as a sidecar; use this standalone pack on nodes that
> aren't running that all-in-one stack.
