# scrypted

[Scrypted](https://www.scrypted.app) is a high-performance home video
integration and automation platform. It connects your IP cameras and smart
devices and exposes them to **Apple HomeKit, Google Home and Amazon Alexa**
with fast, low-latency (including HomeKit Secure Video) streaming and hardware
transcoding. A huge plugin ecosystem covers cameras, NVR, doorbells, lights and
more.

This pack runs Scrypted as a single host-networked Nomad service. Host
networking is required for camera discovery and HomeKit/mDNS.

## Deploy

```bash
nomad-pack run scrypted --registry=nomploy
```

Open `https://<node-ip>:10443` (self-signed certificate) and create the admin
account, then install plugins for your cameras and platforms.

## Configuration

| Variable      | Default                        | Description                                    |
| ------------- | ------------------------------ | ---------------------------------------------- |
| `image`       | `ghcr.io/koush/scrypted:latest`| Container image (pin a tag in production).       |
| `port`        | `10443`                        | Host port for the HTTPS management console.      |
| `http_port`   | `11080`                        | Host port for the HTTP endpoint.                 |
| `data_volume` | `scrypted_volume`              | Volume for server state and plugins.             |
| `constraints` | none                           | Pin to the node on the camera LAN.               |
| `resources`   | 2000 MHz / 2048 MB             | CPU and memory (transcoding wants CPU).          |

All server state and installed plugins persist in `data_volume` under
`/server/volume`. Because Scrypted uses host networking, avoid co-locating it
with other host-networked services that bind the same ports.
