# nginx

nginx as a host-networked Nomad `service` serving a static site. The config and
`index.html` are rendered from pack variables into the alloc's `local/` dir (which
Nomad mounts at `/local`), so there are **no host files** to manage.

## Usage

```
nomad-pack registry add nomploy github.com/Nomploy/nomad-packs
nomad-pack run nginx --registry nomploy --var port=8080
```

Or in nomploy: **Create → Nomad Pack**, pick `nginx` from the Nomploy registry.

## Variables

| Variable | Default | Description |
|---|---|---|
| `job_name` | `nginx` | Nomad job name |
| `image` | `nginx:alpine` | Container image |
| `port` | `8080` | Host port (avoids Traefik's `:80`) |
| `count` | `1` | Stateless — safe to raise (one per node in host mode) |
| `index_html` | welcome page | Contents of `index.html` |
| `resources` | `{cpu=200, memory=128}` | Task resources |

## Notes

- Serves from a rendered `/local/www/index.html`; swap in your own content via the
  `index_html` variable, or fork the pack to add more files.
- To expose it on a domain, add Traefik service tags or route it through nomploy's
  ingress.
