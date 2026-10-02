# vernemq

[VerneMQ](https://vernemq.com) is a high-performance, distributed MQTT broker
built on Erlang/OTP. It's designed to scale to very large numbers of concurrent
IoT/messaging clients, supports MQTT 3.1/3.1.1/5.0, shared subscriptions, QoS 0–2,
clustering, and exposes a built-in HTTP endpoint for status, health and Prometheus
metrics.

This pack runs a single VerneMQ node as a host-networked Nomad service.

## Deploy

```bash
nomad-pack run vernemq --registry=nomploy
```

Point MQTT clients at `<node-ip>:1883`; see broker status at
`http://<node-ip>:8888/status`.

## Configuration

| Variable          | Default                 | Description                                  |
| ----------------- | ----------------------- | -------------------------------------------- |
| `image`           | `vernemq/vernemq:latest`| Container image (pin a tag in production).       |
| `mqtt_port`       | `1883`                  | MQTT listener.                                |
| `http_port`       | `8888`                  | HTTP status / health / metrics.               |
| `allow_anonymous` | `on`                    | Allow anonymous clients (set `off` for prod). |
| `data_volume`     | `vernemq_data`          | Volume for the message store (`/vernemq/data`).|
| `resources`       | 500 MHz / 512 MB        | CPU and memory for the task.                   |

> **Security:** anonymous access is enabled for a frictionless start. Before
> exposing the broker, set `allow_anonymous=off` and configure authentication
> (VerneMQ password file or an auth plugin) via the `DOCKER_VERNEMQ_*` env vars.
