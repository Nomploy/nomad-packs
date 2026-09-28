# ntopng

[ntopng](https://www.ntop.org/products/traffic-analysis/ntop/) is a high-speed,
web-based network traffic monitor. It passively captures packets on a network
interface and shows real-time and historical **flows, talkers, hosts,
application protocols (via nDPI), bandwidth usage, alerts and geolocation** — a
powerful way to see exactly what's happening on your network.

This pack runs ntopng as a single host-networked Nomad service. The official
image bundles its own Redis, so no external database is needed.

## Deploy

```bash
nomad-pack run ntopng --registry=nomploy --var interface=eth0
```

Open `http://<node-ip>:3000` and log in with `admin` / `admin` (change it on
first login).

## Configuration

| Variable      | Default              | Description                                          |
| ------------- | -------------------- | ---------------------------------------------------- |
| `image`       | `ntop/ntopng:latest` | Container image (pin a tag in production).              |
| `port`        | `3000`               | Host port for the web UI.                             |
| `interface`   | `eth0`               | Host NIC to capture traffic from — **set to your NIC**. |
| `data_volume` | `ntopng_data`        | Volume for data + bundled Redis (`/var/lib/ntopng`).  |
| `resources`   | 1000 MHz / 1024 MB   | CPU and memory for the task.                           |

ntopng monitors the interface on the node it runs on, so set `interface` to that
node's real NIC and pin the job there with `constraints`. It needs the
`NET_ADMIN`/`NET_RAW` capabilities (granted here) to capture packets.
