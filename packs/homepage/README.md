# homepage

[Homepage](https://gethomepage.dev) — a modern, fully static, highly customizable
**application dashboard**: service and bookmark tiles, plus live widgets for dozens of
self-hosted apps and infra. A landing page for everything you run. Host-networked Nomad
service with a persistent volume for its YAML config.

## Usage

```sh
nomad-pack registry add nomploy github.com/Nomploy/nomad-packs \
  --var 'allowed_hosts=<node-ip>:3006'
nomad-pack run homepage --registry nomploy --var 'allowed_hosts=<node-ip>:3006'
```

In nomploy: create a Compose service, type **Nomad Pack**, pack `homepage`, set
`allowed_hosts`, then Deploy. Open `http://<node-ip>:3006`.

## Important: allowed_hosts

Recent Homepage rejects any request whose `Host` header isn't in `HOMEPAGE_ALLOWED_HOSTS`
(a security default). **Set `allowed_hosts`** to how you'll reach it — `"<node-ip>:3006"`,
or your domain `"home.example.com"` (comma-separate multiple). If you get a "host
validation" error page, this is why.

## Key variables

| Variable | Default | Notes |
|---|---|---|
| `image` | `ghcr.io/gethomepage/homepage:latest` | Pin a tag in production. |
| `port` | `3006` | Dashboard host port. |
| `allowed_hosts` | `""` | **Set this** (host:port or domain) or Homepage blocks the request. |
| `data_volume` | `homepage_config` | The YAML config. Back it up. |
| `constraints` | `[]` | Pin to a node so the local volume stays put. |
| `resources` | `cpu 300 / mem 256` | Lightweight. |

## Notes

- **Single node.** `count` is fixed to 1 (config on a local volume). Homepage seeds default
  YAML into the volume on first run; edit `services.yaml` / `bookmarks.yaml` /
  `widgets.yaml` / `settings.yaml` there. Pin with `constraints`.
- To show live widgets for other packs, add them in `services.yaml` (each widget needs the
  target service URL + any API key).
