# node-red

[Node-RED](https://nodered.org) — a low-code, **flow-based** programming tool for wiring
together hardware devices, APIs, and online services in a browser editor. A staple for IoT
and home/ops automation. Host-networked Nomad service with a persistent volume; pairs with
the `mosquitto` (MQTT) and `influxdb` packs.

## Usage

```sh
nomad-pack registry add nomploy github.com/Nomploy/nomad-packs
nomad-pack run node-red --registry nomploy
```

In nomploy: create a Compose service, type **Nomad Pack**, pack `node-red`, custom registry
`github.com/Nomploy/nomad-packs`, then Deploy. Open `http://<node-ip>:1880`.

## Key variables

| Variable | Default | Notes |
|---|---|---|
| `image` | `nodered/node-red:latest` | Pin a tag in production. |
| `port` | `1880` | Editor/dashboard (`PORT`). |
| `timezone` | `UTC` | e.g. `Europe/Bratislava`. |
| `data_volume` | `node_red_data` | Flows, credentials, installed nodes. Back it up. |
| `constraints` | `[]` | Pin to a node so the local volume stays put. |
| `resources` | `cpu 400 / mem 256` | Raise for heavy flows. |

## Notes

- **Single node.** `count` is fixed to 1 (local volume). A prestart task chowns the volume to
  uid 1000 (the node-red user). Pin with `constraints`.
- **No authentication by default** — anyone who reaches the editor can change flows. Keep it
  internal, or enable `adminAuth` in the volume's `settings.js`.
