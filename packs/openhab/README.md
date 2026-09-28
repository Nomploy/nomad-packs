# openhab

[openHAB](https://www.openhab.org) (open Home Automation Bus) is a mature,
vendor-neutral open-source home automation platform — a powerful alternative to
Home Assistant. It integrates over **300 technologies and devices** through
"bindings" (Zigbee, Z-Wave, KNX, MQTT, Hue, Sonos and many more), and lets you
build rules, dashboards and voice control that all run locally on your hardware.

This pack runs openHAB as a single host-networked Nomad service. Host
networking is required for UPnP/mDNS device discovery.

## Deploy

```bash
nomad-pack run openhab --registry=nomploy --var timezone=Europe/Bratislava
```

Open `http://<node-ip>:8080` and complete the first-start setup wizard.

## Configuration

| Variable          | Default                  | Description                                  |
| ----------------- | ------------------------ | -------------------------------------------- |
| `image`           | `openhab/openhab:latest` | Container image (pin a tag in production).      |
| `port`            | `8080`                   | Host port for the web UI (HTTP).              |
| `https_port`      | `8443`                   | Host port for the web UI (HTTPS).             |
| `timezone`        | `UTC`                    | Container timezone.                            |
| `conf_volume`     | `openhab_conf`           | Volume for configuration (`/openhab/conf`).   |
| `userdata_volume` | `openhab_userdata`       | Volume for userdata/db (`/openhab/userdata`). |
| `addons_volume`   | `openhab_addons`         | Volume for manual add-ons (`/openhab/addons`).|
| `resources`       | 1000 MHz / 1024 MB       | CPU and memory for the task.                   |

Pin openHAB to the node on your device LAN with `constraints`. Configuration,
the database and add-ons persist across restarts and upgrades.
