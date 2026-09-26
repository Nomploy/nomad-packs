# go-httpbin

[go-httpbin](https://github.com/mccutchen/go-httpbin) — a fast, zero-dependency **HTTP request & response testing
service**, a complete reimplementation of the classic httpbin in Go. Hit endpoints like `/get`, `/status/500`,
`/delay/3`, `/headers` or `/anything` to exercise HTTP clients, proxies, load balancers and webhooks.

Single **stateless** host-networked Nomad service (no volume).

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run go-httpbin --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `8080` | HTTP port (`PORT`). |
| `image` | `ghcr.io/mccutchen/go-httpbin:latest` | Container image. Pin a tag in production. |
| `resources` | `{ cpu = 300, memory = 256 }` | Task resources. Very lightweight. |

> Browse the endpoint list at `http://<host>:8080/`. Being stateless, it needs no storage and scales horizontally —
> handy as a stable test target inside your cluster.
