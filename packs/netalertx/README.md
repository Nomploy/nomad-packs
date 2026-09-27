# netalertx

[NetAlertX](https://netalertx.com) (formerly PiAlert) scans your local network
and keeps a live inventory of every device that connects. It alerts you the
moment an unknown device joins, tracks presence (who's home), records device
history and sessions, and can notify via dozens of channels. A great companion
to a home lab or any network you want to keep an eye on.

This pack runs NetAlertX as a single host-networked Nomad service with the
raw-socket capabilities it needs to scan the LAN.

## Deploy

```bash
nomad-pack run netalertx --registry=nomploy
```

Open `http://<node-ip>:20211`. NetAlertX scans the network of the node it runs
on — pin it to the right node with `constraints`.

## Configuration

| Variable       | Default                              | Description                                  |
| -------------- | ------------------------------------ | -------------------------------------------- |
| `image`        | `ghcr.io/netalertx/netalertx:latest` | Container image (pin a tag in production).     |
| `port`         | `20211`                              | Host port for the web UI.                     |
| `graphql_port` | `20214`                              | Host port for the internal GraphQL API.       |
| `data_volume`  | `netalertx_data`                     | Volume for config and database (`/data`).     |
| `constraints`  | none                                 | Pin to the node whose LAN you want scanned.   |
| `resources`    | 500 MHz / 512 MB                     | CPU and memory for the task.                   |

Config and the device database persist in `data_volume` under `/data/config`
and `/data/db`. A prestart init task creates those folders and fixes
permissions.
