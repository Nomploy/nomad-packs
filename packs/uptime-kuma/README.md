# uptime-kuma

[Uptime Kuma](https://uptime.kuma.pet) — a self-hosted uptime monitoring tool: HTTP(s),
TCP, ping, DNS, keyword and more, with a clean dashboard, status pages, and alerting to
dozens of channels (Slack, Telegram, email, webhooks). Deployed as a host-networked
Nomad service with a persistent Docker volume.

## Usage

```sh
nomad-pack registry add nomploy github.com/Nomploy/nomad-packs
nomad-pack run uptime-kuma --registry nomploy
```

In nomploy: create a Compose service, type **Nomad Pack**, pack `uptime-kuma`, custom
registry `github.com/Nomploy/nomad-packs`, then Deploy.

Open `http://<node-ip>:3001` and create the admin account on first visit.

## Key variables

| Variable | Default | Notes |
|---|---|---|
| `image` | `louislam/uptime-kuma:1` | Pin a tag in production. |
| `port` | `3001` | Web UI host port. Change it if the grafana/monitoring packs already use 3001 on this node. |
| `data_volume` | `uptime_kuma_data` | SQLite DB + config. Back it up. |
| `constraints` | `[]` | Pin to a node so the local volume stays put. |
| `resources` | `cpu 300 / mem 256` | Lightweight. |

## Notes

- **Single node.** `count` is fixed to 1 (SQLite on a local volume). Pin it with
  `constraints`.
- **Backups:** snapshot the `data_volume`.
- Runs its checks *from the node it lands on* — place it where it can reach the targets
  you want to monitor.
