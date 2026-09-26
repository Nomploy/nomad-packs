# rsshub

[RSSHub](https://docs.rsshub.app/) — an **extensible RSS feed generator**. It builds clean RSS/Atom/JSON feeds for
thousands of sites and services that don't offer their own (social media, forums, news, shopping, and much more), so
you can follow anything from your favourite reader.

Single **stateless** host-networked Nomad service (in-memory cache; no Redis or headless browser needed).

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run rsshub --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `1200` | Web UI / feeds port (`PORT`). |
| `cache_type` | `memory` | Cache backend (`CACHE_TYPE`): `memory` (standalone) or `redis`. |
| `image` | `diygod/rsshub:latest` | Container image. Pin a tag in production. |
| `resources` | `{ cpu = 300, memory = 256 }` | Task resources. |

> Browse available routes at `http://<host>:1200`. For a heavy multi-user instance, switch `cache_type` to `redis`
> (add `REDIS_URL`) and add browserless for routes that need a real browser — see the RSSHub docs. Feeds pair nicely
> with [commafeed](https://packs.nomploy.com/packs/commafeed) or [miniflux](https://packs.nomploy.com/packs/miniflux).
> Being stateless, it needs no storage.
