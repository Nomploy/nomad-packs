# ntfy

[ntfy](https://ntfy.sh) — a simple pub/sub notification service. Send push notifications to
your phone or desktop from any script with a plain HTTP `PUT`/`POST`. Great for alerting
from cron jobs, CI, or the `monitoring`/`uptime-kuma` packs. Host-networked Nomad service
with a persistent Docker volume.

## Usage

```sh
nomad-pack registry add nomploy github.com/Nomploy/nomad-packs
nomad-pack run ntfy --registry nomploy
```

In nomploy: create a Compose service, type **Nomad Pack**, pack `ntfy`, custom registry
`github.com/Nomploy/nomad-packs`, then Deploy.

Publish and subscribe:

```sh
curl -d "Backup finished" http://<node-ip>:8090/mytopic
```

Subscribe to `mytopic` in the web app (`http://<node-ip>:8090`) or the ntfy mobile app.

## Key variables

| Variable | Default | Notes |
|---|---|---|
| `image` | `binwiederhier/ntfy:latest` | Pin a tag in production. |
| `port` | `8090` | HTTP server host port. |
| `base_url` | `""` | Public URL — recommended; the web/mobile apps need it correct. |
| `behind_proxy` | `false` | Set true behind a reverse proxy (correct client IPs for rate limits). |
| `data_volume` | `ntfy_data` | cache.db + auth.db + attachments. Back it up. |
| `constraints` | `[]` | Pin to a node so the local volume stays put. |
| `resources` | `cpu 200 / mem 128` | Lightweight. |

## Notes

- **Single node.** `count` is fixed to 1 (local volume). Pin with `constraints`.
- ntfy runs as root in the image, so a fresh volume is writable (no chown).
- For the **mobile apps** you must set `base_url` and serve over HTTPS (put it behind a
  reverse proxy). By default any topic is world-readable/writable; use ntfy's access
  control (`auth.db`) to lock it down.
