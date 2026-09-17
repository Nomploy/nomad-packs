# monitoring

One-click observability: **Prometheus + node-exporter + cAdvisor + Grafana** in a single
host-networked Nomad job. You get host metrics (CPU/mem/disk/net) *and* per-container
metrics — which is what fills the gap where Nomad's own per-alloc stats read all-zero on
cgroup v2. Grafana comes pre-wired to Prometheus, so it works the moment it's up.

Everything shares the host network, so Prometheus scrapes the exporters on `127.0.0.1`
and Grafana talks to Prometheus on `127.0.0.1`. The whole stack runs **unprivileged**.

## Usage

```sh
nomad-pack registry add nomploy github.com/Nomploy/nomad-packs
nomad-pack run monitoring --registry nomploy
```

In nomploy: create a Compose service, type **Nomad Pack**, pack `monitoring`, custom
registry `github.com/Nomploy/nomad-packs`, then Deploy.

## What you get

- **Grafana** — `http://<node-ip>:3001` (login `admin` / `admin`; Prometheus datasource
  already provisioned). Import a dashboard to start: **1860** (Node Exporter Full),
  **14282** (cAdvisor).
- **Prometheus** — `http://<node-ip>:9090`. Check **Status → Targets** to confirm the
  `node`, `cadvisor` (and optional `nomad`) scrapes are `UP`.
- **node-exporter** (`:9100`) and **cAdvisor** (`:8082`) — the scrape sources.

## Key variables

| Variable | Default | Notes |
|---|---|---|
| `grafana_port` / `prometheus_port` | `3001` / `9090` | Grafana avoids the panel's `:3000`. |
| `node_exporter_port` / `cadvisor_port` | `9100` / `8082` | cAdvisor avoids the common `:8080` clash. |
| `enable_cadvisor` | `true` | Set false for host-only metrics, or if cAdvisor won't start. |
| `retention` | `15d` | Prometheus TSDB retention. |
| `scrape_interval` | `15s` | Global scrape interval. |
| `nomad_metrics_url` | `""` | Optional Nomad scrape target, e.g. `127.0.0.1:4646` (needs Nomad prometheus telemetry). |
| `grafana_admin_password` | `admin` | **Change this.** |
| `*_data_volume` | `monitoring_*_data` | Prometheus TSDB + Grafana state. Back up. |
| `constraints` | `[]` | Pin to a node — metrics are for the node the alloc lands on. |

Per-task resources: `prometheus_resources`, `grafana_resources`, `exporter_resources`.

## Scope & notes

- **Single node.** `count` is fixed to 1 with local volumes, so the metrics you see are
  for the one node this alloc runs on. Pin it with `constraints`. To watch every node,
  run node-exporter/cAdvisor per node and add them as scrape targets — a future
  multi-node variant.
- **cAdvisor** runs with read-only host mounts and no `--privileged`. A few metrics
  (e.g. perf events) need `--device=/dev/kmsg`/privileged; add them if you need those.
- **Nomad metrics:** set `nomad_metrics_url` and enable Nomad's Prometheus telemetry
  (`telemetry { prometheus_metrics = true, publish_allocation_metrics = true }`).
- Pairs well with the **loki** pack (logs) and **seaweedfs** (remote-write/backends).
