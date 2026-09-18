# it-tools

[IT Tools](https://it-tools.tech) — a handy collection of offline developer/ops utilities
in a single web app: encoders/decoders, converters, generators (UUID, tokens, hashes),
formatters, network helpers, and more. Everything runs client-side. Stateless
host-networked Nomad service.

## Usage

```sh
nomad-pack registry add nomploy github.com/Nomploy/nomad-packs
nomad-pack run it-tools --registry nomploy
```

In nomploy: create a Compose service, type **Nomad Pack**, pack `it-tools`, custom registry
`github.com/Nomploy/nomad-packs`, then Deploy.

Open `http://<node-ip>:8092`.

## Key variables

| Variable | Default | Notes |
|---|---|---|
| `image` | `corentinth/it-tools:latest` | Pin a tag in production. |
| `port` | `8092` | Web app host port (rebinds nginx via a rendered config). |
| `count` | `1` | Stateless, so >1 is fine on distinct ports/nodes. |
| `resources` | `cpu 200 / mem 128` | Lightweight. |

## Notes

- **Stateless** — no volume; nothing to back up.
- The image serves on port 80 internally; this pack renders an nginx `server` block so it
  listens on `port` for host networking.
