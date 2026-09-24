# zigbee2mqtt

[Zigbee2MQTT](https://www.zigbee2mqtt.io) — bridges your **Zigbee** devices to **MQTT** using a USB Zigbee
coordinator, freeing them from vendor hubs and clouds. Supports 3000+ devices, a web frontend for pairing and
control, and seamless **Home Assistant** integration.

Single host-networked Nomad service with a passed-through serial device and a persistent data volume.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run zigbee2mqtt --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `8124` | Web frontend port (`ZIGBEE2MQTT_CONFIG_FRONTEND_PORT`). |
| `serial_device` | `/dev/ttyACM0` | Host path to your Zigbee USB coordinator. Prefer a `/dev/serial/by-id/…` path. |
| `mqtt_server` | `mqtt://127.0.0.1:1883` | MQTT broker URL (`ZIGBEE2MQTT_CONFIG_MQTT_SERVER`). |
| `data_volume` | `zigbee2mqtt_data` | `/app/data` — config, database, network state. |
| `image` | `ghcr.io/koenkk/zigbee2mqtt:latest` | Container image. Pin a tag in production. |
| `resources` | `{ cpu = 300, memory = 256 }` | Task resources. |

**Requirements:** a Zigbee USB coordinator plugged into the node (the pack passes `serial_device` into the
container — **pin the job to that node** with `constraints`), and an MQTT broker (deploy the `mosquitto` pack
first). Open the frontend, temporarily enable "permit join" to pair devices, then point `home-assistant` at the
same broker. **Back up the data volume** — losing it means re-pairing every device. Front the UI with a reverse
proxy for TLS.
