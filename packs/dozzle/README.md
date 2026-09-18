# dozzle

[Dozzle](https://dozzle.dev) — a lightweight, real-time **log viewer for Docker
containers**, right in your browser. No database, no persistence — it just streams logs
live from the Docker socket. A quick way to tail container logs without standing up the
full `loki` stack.

## Usage

```sh
nomad-pack registry add nomploy github.com/Nomploy/nomad-packs
nomad-pack run dozzle --registry nomploy
```

In nomploy: create a Compose service, type **Nomad Pack**, pack `dozzle`, custom registry
`github.com/Nomploy/nomad-packs`, then Deploy.

Open `http://<node-ip>:8091`.

## Key variables

| Variable | Default | Notes |
|---|---|---|
| `image` | `amir20/dozzle:latest` | Pin a tag in production. |
| `port` | `8091` | Web UI host port. |
| `constraints` | `[]` | Pin to the node whose containers you want to view. |
| `resources` | `cpu 200 / mem 128` | Lightweight. |

## Notes

- **Per node.** Dozzle shows containers on the node it runs on (it reads that node's Docker
  socket). Pin it with `constraints`, or run one per node.
- **Stateless** — no volume.
- **Security:** there's no authentication by default and it exposes all container logs.
  Keep it on an internal network, or enable Dozzle's auth (`DOZZLE_AUTH_PROVIDER`) / front
  it with an authenticating proxy.
- Mounts the Docker socket read-only.
