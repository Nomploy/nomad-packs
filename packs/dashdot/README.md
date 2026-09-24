# dashdot

[dash.](https://getdashdot.com) (dashdot) — a simple, modern **server dashboard**. See live CPU, memory,
storage, network throughput, and OS details at a glance — perfect for a homelab or a small private server.

Single host-networked Nomad service that reads the host filesystem read-only.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run dashdot --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `3001` | Dashboard port (`PORT`). The container listens on 3001. |
| `image` | `mauricenino/dashdot:latest` | Container image. Pin a tag in production. |
| `resources` | `{ cpu = 300, memory = 256 }` | Task resources. |

The job binds the host root at `/mnt/host` (read-only) so storage widgets reflect the real disks, and uses
host networking for accurate network stats. A few extras (disk temperatures, some SMART data) require a
**privileged** container — not requested here; add it yourself if your cluster allows it. Run one instance per
node you want to monitor. It's an **unauthenticated** dashboard — keep it on an internal network or behind a
reverse proxy.
