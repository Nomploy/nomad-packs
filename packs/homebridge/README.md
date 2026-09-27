# homebridge

[Homebridge](https://homebridge.io) is a lightweight server that emulates the
Apple HomeKit API, letting you control smart-home devices that don't natively
support HomeKit (thousands of plugins for cameras, lights, sensors, TVs and
more) from the Apple Home app and Siri. It ships with **Config UI X**, a web
dashboard for installing plugins and editing config.

This pack runs Homebridge as a single host-networked Nomad service. Host
networking is required so HomeKit discovery (mDNS/Bonjour via the built-in
Avahi daemon) works on your LAN.

## Deploy

```bash
nomad-pack run homebridge --registry=nomploy
```

Open the Config UI at `http://<node-ip>:8581` (default login `admin` / `admin`
— change it immediately). Install plugins from the UI, then add the bridge in
the Apple Home app using the PIN it displays.

## Configuration

| Variable        | Default                        | Description                                  |
| --------------- | ------------------------------ | -------------------------------------------- |
| `image`         | `homebridge/homebridge:latest` | Container image (pin a tag in production).    |
| `port`          | `8581`                         | Host port for the Config UI X.               |
| `timezone`      | `UTC`                          | Container timezone.                           |
| `enable_avahi`  | `1`                            | Built-in Avahi mDNS daemon for discovery.    |
| `config_volume` | `homebridge_config`            | Named volume mounted at `/homebridge`.        |
| `resources`     | 500 MHz / 512 MB               | CPU and memory for the task.                  |

All config, plugins and paired-accessory state persist in the `config_volume`
under `/homebridge`, so upgrades and restarts keep your setup.
