# domoticz

[Domoticz](https://www.domoticz.com) is a lightweight, open-source home
automation system. It lets you monitor and control a wide range of devices —
lights and switches, temperature/humidity/energy sensors, smart meters, weather
stations and more — through a fast, mobile-friendly web UI, with events,
scripting (Blockly/Lua/dzVents) and notifications. It runs happily on modest
hardware.

This pack runs Domoticz as a single host-networked Nomad service. Host
networking lets it reach devices and discovery on your LAN.

## Deploy

```bash
nomad-pack run domoticz --registry=nomploy
```

Open `http://<node-ip>:8080`.

## Configuration

| Variable      | Default                    | Description                                      |
| ------------- | -------------------------- | ------------------------------------------------ |
| `image`       | `domoticz/domoticz:stable` | Container image (pin a tag in production).          |
| `port`        | `8080`                     | Host port for the web UI (HTTP).                  |
| `https_port`  | `8443`                     | Host port for the web UI (HTTPS).                 |
| `data_volume` | `domoticz_userdata`        | Volume for the database/config (`/opt/domoticz/userdata`). |
| `resources`   | 500 MHz / 512 MB           | CPU and memory for the task.                       |

The HTTPS port is moved off the privileged `443` (to `8443` by default) via
`EXTRA_CMD_ARG` so it doesn't clash with an ingress proxy. To use USB radios
(Z-Wave/Zigbee/RFXCOM), add a `devices` entry to the Docker task for the
relevant `/dev/tty*` path and pin the job to that node.
