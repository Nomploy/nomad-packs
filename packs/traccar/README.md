# traccar

[Traccar](https://www.traccar.org) is a popular open-source GPS tracking
platform. It speaks over **200 device protocols** (commercial trackers, phones
via the Traccar Client app, OBD dongles and more), and gives you live maps,
trip and stop detection, geofences, reports, notifications and a full REST API.

This pack runs Traccar as a single host-networked Nomad service using its
**embedded H2 database**, so there's nothing else to set up to get started.

## Deploy

```bash
nomad-pack run traccar --registry=nomploy
```

Open `http://<node-ip>:8082` and register — the first account created becomes
the administrator.

## Configuration

| Variable      | Default                 | Description                                   |
| ------------- | ----------------------- | --------------------------------------------- |
| `image`       | `traccar/traccar:latest`| Container image (pin a tag in production).       |
| `port`        | `8082`                  | Host port for the web UI.                       |
| `data_volume` | `traccar_data`          | Volume for the H2 database (`/opt/traccar/data`).|
| `logs_volume` | `traccar_logs`          | Volume for logs (`/opt/traccar/logs`).          |
| `resources`   | 500 MHz / 1024 MB       | CPU and memory for the task.                     |

Devices connect on the protocol port range **5000-5150** (TCP/UDP), which host
networking exposes on the node. For production, configure an external MySQL or
PostgreSQL database via a mounted `traccar.xml` instead of the embedded H2 store.
