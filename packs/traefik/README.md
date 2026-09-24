# traefik

[Traefik](https://traefik.io) — a modern reverse proxy and load balancer that **auto-discovers** your
services and routes traffic to them, with a live dashboard and middlewares (auth, redirects, rate limiting,
…). This pack wires Traefik to **Nomad's native service provider**, so any Nomad job tagged for Traefik is
routed automatically — no static config to maintain.

Single host-networked Nomad service.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run traefik --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `http_port` / `https_port` | `80` / `443` | HTTP (`web`) and HTTPS (`websecure`) entrypoints. |
| `dashboard_port` | `8080` | Dashboard/API port (served **insecurely** — keep internal). |
| `nomad_address` | `http://127.0.0.1:4646` | Nomad HTTP API Traefik reads services from. |
| `nomad_token` | `""` | Nomad ACL token, if ACLs are enabled. |
| `image` | `traefik:v3.3` | Container image. Pin a tag in production. |
| `resources` | `{ cpu = 500, memory = 256 }` | Task resources. |

Expose a job by adding Traefik tags to its Nomad `service`:

```hcl
tags = [
  "traefik.enable=true",
  "traefik.http.routers.myapp.rule=Host(`app.example.com`)",
]
```

> **Port conflict:** this binds `http_port`/`https_port` on the node — don't run it where another ingress
> already listens on those ports (for example a nomploy control plane's own Traefik). For automatic TLS, add
> an ACME `certResolver` and a certs volume. Dashboard is insecure; put it behind auth or keep it internal.
