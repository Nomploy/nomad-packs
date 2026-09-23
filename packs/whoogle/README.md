# whoogle

[Whoogle Search](https://github.com/benbusby/whoogle-search) — a self-hosted, ad-free,
privacy-respecting metasearch engine that proxies Google results with no tracking, no cookies, and
no JavaScript required.

Stateless host-networked Nomad service.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run whoogle --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `5010` | Web UI port (`EXPOSE_PORT`). |
| `username` / `password` | `""` | Optional HTTP basic auth (`WHOOGLE_USER`/`WHOOGLE_PASS`). |
| `image` | `benbusby/whoogle-search:latest` | Container image. Pin a tag in production. |
| `resources` | `{ cpu = 300, memory = 256 }` | Task resources. |

Add it as a browser search engine with `http://<node-ip>:5010/search?q=%s`. It's open by default —
set `username`/`password` and front with TLS if it's internet-facing.
