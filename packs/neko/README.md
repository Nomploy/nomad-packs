# neko

[neko](https://neko.m1k1o.net) runs a full web browser (or other GUI app) inside
a container and streams it to your browser over **WebRTC**, with shared or
exclusive control. Use it for watch parties, collaborative browsing, giving
someone a throwaway browser, or isolating risky sites away from your own machine.

This pack runs neko as a single host-networked Nomad service (default image:
Firefox).

## Deploy

```bash
nomad-pack run neko --registry=nomploy \
  --var user_password=$(openssl rand -hex 8) \
  --var admin_password=$(openssl rand -hex 8) \
  --var nat1to1_ip=<node-public-ip>
```

Open `http://<node-ip>:8080` and log in.

## Configuration

| Variable         | Default                              | Description                                   |
| ---------------- | ------------------------------------ | --------------------------------------------- |
| `image`          | `ghcr.io/m1k1o/neko/firefox:latest`  | Browser/app image (chromium, vlc, kde, …).      |
| `port`           | `8080`                               | Host port for the web UI.                      |
| `webrtc_epr`     | `56000-56100`                        | WebRTC UDP media port range (host networking). |
| `nat1to1_ip`     | _(auto)_                             | Public IP for WebRTC if the node is behind NAT.|
| `user_password`  | `neko`                               | Member password — **change this**.             |
| `admin_password` | `admin`                              | Admin password — **change this**.              |
| `screen`         | `1280x720@30`                        | Virtual screen resolution/refresh.             |
| `shm_size`       | `2147483648` (2 GB)                  | Shared memory for the browser.                 |
| `resources`     | 2000 MHz / 2048 MB                   | CPU and memory (a live browser is hungry).      |

> **WebRTC:** media flows over the UDP range `webrtc_epr`, which host networking
> opens directly on the node — allow it through the firewall. Behind NAT, set
> `nat1to1_ip` to the node's public address.
