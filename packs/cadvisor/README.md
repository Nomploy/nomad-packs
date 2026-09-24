# cadvisor

[cAdvisor](https://github.com/google/cadvisor) (Container Advisor) — Google's tool for live **per-container**
resource usage and performance metrics: CPU, memory, network, and filesystem, with a built-in UI and a
**Prometheus** metrics endpoint. The standard companion for container monitoring dashboards.

Single host-networked Nomad service that reads the host and Docker read-only.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run cadvisor --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `8080` | UI / metrics port (`--port`). |
| `image` | `gcr.io/cadvisor/cadvisor:latest` | Container image. Pin a tag in production. |
| `resources` | `{ cpu = 300, memory = 256 }` | Task resources. |

Scrape `http://<node-ip>:8080/metrics` from Prometheus (the `monitoring` pack) and chart it in Grafana. The job
bind-mounts `/`, `/var/run`, `/sys`, and `/var/lib/docker` (mostly read-only) so cAdvisor can see all containers.
Run **one instance per node** (pin with `constraints`). The endpoint is unauthenticated — keep it internal.

> Note: the `monitoring` pack already bundles cAdvisor as a sidecar; use this standalone pack when you want
> cAdvisor on nodes that aren't running that all-in-one stack.
