# soketi

[soketi](https://soketi.app) — a fast, open-source WebSocket server that is protocol-compatible
with **Pusher Channels**, for real-time features (live updates, notifications, presence). A
self-hosted drop-in for Pusher.

Stateless host-networked Nomad service with a default app credential set.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run soketi --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `6001` | WebSocket port (`SOKETI_PORT`). |
| `metrics_port` | `9601` | Prometheus metrics port. |
| `app_id` / `app_key` / `app_secret` | `app-id` / `app-key` / `app-secret` | Default app credentials. **Change them.** |
| `image` | `quay.io/soketi/soketi:latest-16-alpine` | Image. Pin a tag in production. |
| `resources` | `{ cpu = 300, memory = 256 }` | Task resources. |

Configure a Pusher-compatible client with the app id/key/secret above and `host = <node-ip>`,
`port = 6001`, `forceTLS: false`. State is in-memory (single node) — front with TLS for browser
clients and change the default credentials.
