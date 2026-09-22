# mosquitto

[Eclipse Mosquitto](https://mosquitto.org) — a lightweight open-source **MQTT broker** for
IoT and pub/sub messaging (MQTT 3.1 / 3.1.1 / 5.0). Host-networked Nomad service with a
rendered config and a persistent volume for retained messages.

## Usage

```sh
nomad-pack registry add nomploy github.com/Nomploy/nomad-packs
nomad-pack run mosquitto --registry nomploy
```

In nomploy: create a Compose service, type **Nomad Pack**, pack `mosquitto`, custom registry
`github.com/Nomploy/nomad-packs`, then Deploy. Broker at `<node-ip>:1883`.

## Key variables

| Variable | Default | Notes |
|---|---|---|
| `image` | `eclipse-mosquitto:2` | Pin a tag in production. |
| `port` | `1883` | MQTT listener (TCP). |
| `allow_anonymous` | `true` | Open on a trusted network; set false + a password file for real use. |
| `data_volume` | `mosquitto_data` | Persistence DB / retained messages. |
| `constraints` | `[]` | Pin to a node so the local volume stays put. |
| `resources` | `cpu 200 / mem 128` | Lightweight. |

## Notes

- **Single node.** `count` is fixed to 1 (local volume). A prestart task chowns the volume to
  uid 1883 (the mosquitto user). Pin with `constraints`.
- **Security:** `allow_anonymous = true` lets anyone publish/subscribe — only for trusted
  networks. For real use, disable it and mount a `passwordfile` (extend the rendered config).
- This pack exposes the plain MQTT TCP listener; add a `listener` for WebSockets (9001) or
  TLS by extending the config.
