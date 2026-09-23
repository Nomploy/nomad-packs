# esphome

[ESPHome](https://esphome.io) — build and manage firmware for ESP32/ESP8266 devices from YAML, with
a web dashboard, OTA updates, and native Home Assistant integration.

Deployed host-networked (for mDNS device discovery) with a `/config` volume.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run esphome --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `6052` | Dashboard port. |
| `data_volume` | `esphome_config` | `/config` — device YAML + build cache. |
| `image` | `ghcr.io/esphome/esphome:latest` | Image. Pin a tag in production. |
| `resources` | `{ cpu = 1000, memory = 1024 }` | Task resources (compiling is CPU-heavy). |

Create device configs in the dashboard and flash over the network (OTA). The initial flash of a new
device usually needs USB on a machine with the device attached. Pairs with the
[home-assistant](../home-assistant) and [mosquitto](../mosquitto) packs. Pin the job to the node
holding the volume with `constraints`.
