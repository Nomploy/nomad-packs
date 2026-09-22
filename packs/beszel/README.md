# beszel

[Beszel](https://beszel.dev) — a lightweight server monitoring hub: historical CPU, memory, disk,
and network stats, Docker container stats, and configurable alerts, all in a small self-hosted
web app. A simpler alternative to the [monitoring](../monitoring) (Prometheus/Grafana) pack.

This pack runs the **hub** (web UI + database). To collect metrics, run the **beszel-agent** on
each machine you want to monitor.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run beszel --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `8090` | Hub web UI port. |
| `data_volume` | `beszel_data` | `/beszel_data` — SQLite database + config. |
| `image` | `henrygd/beszel:latest` | Hub image. Pin a tag in production. |
| `resources` | `{ cpu = 200, memory = 128 }` | Task resources. |

Create the admin account on first visit. **Add system** in the UI generates the agent install
command + `TOKEN`/`KEY` for each host; run `henrygd/beszel-agent` there (separate from this pack).
Pin the job to the node holding the volume with `constraints`.
