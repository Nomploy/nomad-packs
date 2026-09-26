# byparr

[Byparr](https://github.com/ThePhaseless/Byparr) — a maintained, drop-in **FlareSolverr replacement**. It uses a real
headless browser to solve Cloudflare and other anti-bot challenges, then returns the page and cookies over a simple
HTTP API — so indexers and scrapers can fetch protected sites. API-compatible with FlareSolverr's `/v1` endpoint.

Single **stateless** host-networked Nomad service (no volume).

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run byparr --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `8191` | API port (`PORT`). FlareSolverr-compatible. |
| `image` | `ghcr.io/thephaseless/byparr:latest` | Container image. Pin a tag in production. |
| `resources` | `{ cpu = 1000, memory = 1024 }` | Task resources. A browser is memory-hungry. |

> **Pairs with** [prowlarr](https://packs.nomploy.com/packs/prowlarr) / indexers: set the FlareSolverr proxy URL to
> `http://<host>:8191`. It runs a Chromium instance (2 GB `/dev/shm` is configured), so give it CPU/RAM headroom.
> Being stateless, it needs no storage.
