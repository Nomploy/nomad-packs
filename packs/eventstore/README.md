# eventstore

[EventStoreDB](https://www.kurrent.io) (Kurrent) — a database purpose-built for **event sourcing**. Store an
append-only log of immutable events organized into streams, consume them with catch-up and persistent
subscriptions, and derive read models with built-in projections. Ships a web admin UI and gRPC SDKs for many
languages.

Single host-networked node in insecure/dev mode, with persistent data and log volumes.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run eventstore --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `2113` | HTTP API / gRPC / admin UI port. |
| `run_projections` | `All` | `EVENTSTORE_RUN_PROJECTIONS`: `None`, `System`, or `All`. |
| `data_volume` | `eventstore_data` | `/var/lib/eventstore` — all streams and events. |
| `logs_volume` | `eventstore_logs` | `/var/log/eventstore`. |
| `image` | `eventstore/eventstore:lts` | Container image. Pin a tag in production. |
| `resources` | `{ cpu = 500, memory = 512 }` | Task resources. |

Open the admin UI at `http://<node-ip>:2113`; connect SDKs with `esdb://<node-ip>:2113?tls=false`. This runs
**single-node and insecure** (no TLS or auth) for easy self-hosting — keep it on an internal network, or
configure certificates and a cluster for production. Pin the job to the node holding the volumes with
`constraints`.
