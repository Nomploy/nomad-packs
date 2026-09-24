# flaresolverr

[FlareSolverr](https://github.com/FlareSolverr/FlareSolverr) — a proxy server that solves **Cloudflare** and
DDoS-GUARD challenges using a headless browser. Tools like **Prowlarr**, Jackett, and **Bazarr** send requests
through it so they can reach indexers and subtitle providers hidden behind those protections.

Single host-networked, **stateless** Nomad service.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run flaresolverr --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `8191` | API port (`PORT`). |
| `log_level` | `info` | Logging verbosity (`LOG_LEVEL`): `info` or `debug`. |
| `tz` | `UTC` | Container timezone (`TZ`). |
| `image` | `ghcr.io/flaresolverr/flaresolverr:latest` | Container image. Pin a tag in production. |
| `resources` | `{ cpu = 500, memory = 512 }` | Task resources. Runs a headless browser. |

In Prowlarr (or Jackett/Bazarr) add a **FlareSolverr proxy** with the URL `http://127.0.0.1:8191` (co-located on
the same node) and tag the indexers that need it. FlareSolverr launches a headless browser to solve challenges, so
it uses noticeable CPU/RAM while working. Keep it on an internal network.
