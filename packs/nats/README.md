# nats

[NATS](https://nats.io) — a lightweight, high-performance messaging system: pub/sub,
request-reply, and queue groups, with **JetStream** for persistence (streams, key-value,
object store). A cloud-native alternative to the heavier `rabbitmq` broker.

Host-networked Nomad service with a persistent volume for the JetStream store and the HTTP
monitoring endpoint enabled.

## Usage

```sh
nomad-pack registry add nomploy github.com/Nomploy/nomad-packs
nomad-pack run nats --registry nomploy
```

In nomploy: create a Compose service, type **Nomad Pack**, pack `nats`, custom registry
`github.com/Nomploy/nomad-packs`, then Deploy.

- **Client** — `nats://<node-ip>:4222`
- **Monitoring** — `http://<node-ip>:8222/varz` (also `/healthz`, `/jsz`)

## Key variables

| Variable | Default | Notes |
|---|---|---|
| `image` | `nats:2` | Pin a tag in production. |
| `client_port` | `4222` | Client connections. |
| `monitoring_port` | `8222` | HTTP monitoring. |
| `jetstream` | `true` | Persistence. When true, `/data` is the store on the volume. |
| `auth_token` | `""` | Empty = open. Set it → `nats://<token>@host:4222`. |
| `data_volume` | `nats_data` | JetStream store. Back it up. |
| `constraints` | `[]` | Pin to a node so the local volume stays put. |
| `resources` | `cpu 300 / mem 256` | Lightweight. |

## Notes

- **Single node.** `count` is fixed to 1 with a local JetStream volume. Pin it with
  `constraints`. A NATS cluster (routes/gateways) is out of scope for this pack.
- NATS runs as root in the image, so a fresh named volume is writable with no chown.
- With `jetstream = false` the volume isn't mounted — you get core NATS with no
  persistence.
- **Backups:** snapshot the `data_volume` (JetStream streams/KV live there).
