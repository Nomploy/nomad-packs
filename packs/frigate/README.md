# frigate

[Frigate](https://frigate.video) is a complete, local network video recorder
(NVR) with real-time AI object detection for IP cameras. It runs detection on
the decoded video stream (with optional Coral/GPU acceleration), records only
when it matters, and integrates tightly with Home Assistant. Everything stays
on your own hardware — no cloud.

This pack runs Frigate as a single host-networked Nomad service with the
shared-memory and tmpfs settings it needs for frame buffering and recording.

## Deploy

```bash
nomad-pack run frigate --registry=nomploy
```

Open `http://<node-ip>:8971` and create the admin account. Frigate starts with
**no cameras** — edit `config.yml` in the `config_volume` to add them, then
restart the job. See the [config reference](https://docs.frigate.video).

## Configuration

| Variable        | Default                                  | Description                                       |
| --------------- | ---------------------------------------- | ------------------------------------------------- |
| `image`         | `ghcr.io/blakeblackshear/frigate:stable` | Container image (pin a tag in production).          |
| `port`          | `8971`                                   | Host port for the authenticated web UI.            |
| `rtsp_port`     | `8554`                                   | go2rtc RTSP restream port.                          |
| `webrtc_port`   | `8555`                                   | WebRTC live-view port (TCP + UDP).                 |
| `shm_size`      | `268435456` (256 MB)                     | Shared memory for frame buffers; raise for cameras.|
| `cache_size`    | `1073741824` (1 GB)                      | tmpfs size for `/tmp/cache`.                        |
| `config_volume` | `frigate_config`                         | Volume for config and the database (`/config`).    |
| `media_volume`  | `frigate_media`                          | Volume for recordings and snapshots.               |
| `resources`     | 2000 MHz / 2048 MB                       | CPU and memory (detection is CPU-heavy on CPU).    |

A prestart init task seeds a minimal `config.yml` (only if one doesn't already
exist, so your edits are preserved) and fixes volume permissions.
