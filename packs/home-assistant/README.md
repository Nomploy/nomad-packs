# home-assistant

[Home Assistant](https://www.home-assistant.io) — the leading open-source home-automation platform.
Control lights, sensors, media, and thousands of integrations from one dashboard, with local
control and privacy.

Deployed host-networked (required for device discovery / mDNS) with a `/config` volume.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run home-assistant --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `8123` | Web UI port. See note. |
| `data_volume` | `home_assistant_config` | `/config` — config, database, integrations. |
| `image` | `ghcr.io/home-assistant/home-assistant:stable` | Image. Pin a tag in production. |
| `resources` | `{ cpu = 1000, memory = 1024 }` | Task resources. |

Complete the onboarding wizard on first visit. Pairs with the [mosquitto](../mosquitto) (MQTT),
[node-red](../node-red), and [esphome](../esphome) packs.

## Notes

- Home Assistant binds `8123`; there's no env to change it — set `http.server_port` in
  `configuration.yaml` after first boot and update the `port` variable to match.
- USB dongles (Zigbee/Z-Wave) or Bluetooth need device passthrough / extra privileges not
  configured here. Pin the job to the node holding the volume with `constraints`.
