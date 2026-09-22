# emqx

[EMQX](https://www.emqx.io) — a high-performance, scalable MQTT broker for IoT, with a web
dashboard, MQTT over TCP and WebSocket, a rules engine, and authentication/ACLs.

Single host-networked Nomad service. A busybox prestart task chowns the data volume to EMQX's UID
(it runs as uid 1000). A feature-rich alternative to the [mosquitto](../mosquitto) pack.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run emqx --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `mqtt_port` | `1883` | MQTT over TCP. |
| `ws_port` | `8083` | MQTT over WebSocket. |
| `dashboard_port` | `18083` | Dashboard + REST API. |
| `dashboard_password` | `public` | Initial `admin` password. **Change it.** |
| `uid` | `1000` | User EMQX runs as; data volume is chown'd to it. |
| `data_volume` | `emqx_data` | `/opt/emqx/data` — retained messages, sessions, rules. |
| `image` | `emqx/emqx:5` | Container image. Pin a tag in production. |
| `resources` | `{ cpu = 1000, memory = 512 }` | Task resources. |

The node name is pinned to `emqx@127.0.0.1` so data survives restarts (same idea as the rabbitmq
pack). Clients may connect anonymously by default — enable auth/ACLs from the dashboard for
anything internet-facing. Pin the job to the node holding the volume with `constraints`.
