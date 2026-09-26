# pyroscope

[Pyroscope](https://github.com/grafana/pyroscope) — Grafana's open-source **continuous profiling** backend and UI.
Continuously collect CPU, memory and other profiles from your applications and explore them as flame graphs over time
to find performance and resource bottlenecks. Query from its own UI or from Grafana.

Single host-networked Nomad service (single-binary mode) with a persistent data volume.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run pyroscope --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `4040` | Web UI / ingest port (`-server.http-listen-port`). |
| `image` | `grafana/pyroscope:latest` | Container image. Pin a tag in production. |
| `data_volume` | `pyroscope_data` | `/data` — the local profile store. |
| `resources` | `{ cpu = 300, memory = 256 }` | Task resources. Bump for heavy ingestion. |

> Send profiles from your apps with the Pyroscope SDKs, Grafana Alloy, or the OTel profiling exporter, pointing them at
> `http://<host>:4040`. Add it to [grafana](https://packs.nomploy.com/packs/grafana) as a data source to explore
> flame graphs there. A prestart init task chowns the data volume to uid `10001`. Pin the job to the node holding the
> volume with `constraints`.
