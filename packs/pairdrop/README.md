# pairdrop

[PairDrop](https://pairdrop.net) — a browser-based, AirDrop-style file and text sharing tool. Send
between devices on the same network (peer-to-peer via WebRTC) or paired remotely — no app, no
account.

Stateless host-networked Nomad service.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run pairdrop --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `3017` | Web UI port (`PORT`). |
| `rate_limit` | `false` | Per-IP rate limiting (`RATE_LIMIT`). |
| `image` | `ghcr.io/schlagmichdoch/pairdrop:latest` | Image. Pin a tag in production. |
| `resources` | `{ cpu = 200, memory = 128 }` | Task resources. |

Open the URL on two devices to auto-discover and transfer. WebRTC needs a **secure context** beyond
localhost — front it with TLS (`caddy` / `nginx-proxy-manager`) for real use.
