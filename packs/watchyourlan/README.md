# watchyourlan

[WatchYourLAN](https://github.com/aceberg/WatchYourLAN) — a lightweight **network device monitor**. It periodically
ARP-scans your LAN, records every host it sees, shows an online/offline history and a live dashboard, and can send
notifications (via Shoutrrr) when a device appears or goes away. Handy for spotting unknown devices on your network.

Single host-networked Nomad service with a persistent SQLite database.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run watchyourlan --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `8840` | Web UI port (`PORT`). |
| `ifaces` | `eth0` | **Set this.** Interface(s) to scan (`IFACES`), space-separated — run `ip -br link` on the host. |
| `timeout` | `60` | Seconds between scans (`TIMEOUT`). |
| `tz` | `UTC` | Container timezone (`TZ`). |
| `image` | `aceberg/watchyourlan:latest` | Container image. Pin a tag in production. |
| `data_volume` | `watchyourlan_data` | `/data/WatchYourLAN` — the SQLite database. |
| `resources` | `{ cpu = 300, memory = 256 }` | Task resources. |

> **Needs the host network to see your LAN.** This pack runs on the host network with `NET_RAW`/`NET_ADMIN` so it can
> ARP-scan. `ifaces` must name a real host interface, and the job only sees the LAN of the node it runs on — pin it
> with `constraints` to the node whose network you want to watch.
