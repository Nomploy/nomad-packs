# whoami

[whoami](https://github.com/traefik/whoami) — a tiny HTTP service that echoes the request
back (hostname, client IP, headers, TLS info). It's the go-to for testing ingress/routing,
load balancing, and service discovery on a cluster. Stateless host-networked Nomad service.

## Usage

```sh
nomad-pack registry add nomploy github.com/Nomploy/nomad-packs
nomad-pack run whoami --registry nomploy
```

In nomploy: create a Compose service, type **Nomad Pack**, pack `whoami`, custom registry
`github.com/Nomploy/nomad-packs`, then Deploy.

```sh
curl http://<node-ip>:8097
```

## Key variables

| Variable | Default | Notes |
|---|---|---|
| `image` | `traefik/whoami:latest` | Pin a tag in production. |
| `port` | `8097` | Listen port. |
| `count` | `1` | Set >1 to test load balancing (the `Hostname` line varies per replica). |
| `constraints` | `[]` | Placement. |
| `resources` | `cpu 100 / mem 32` | Tiny. |

## Notes

- **Stateless** — nothing to persist. Safe to run multiple replicas.
- Useful for confirming that a reverse proxy / Traefik route reaches the right backend, or
  that Nomad service discovery is working.
