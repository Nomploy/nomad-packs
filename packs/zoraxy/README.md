# zoraxy

[Zoraxy](https://zoraxy.aroz.org) is a general-purpose, self-hosted HTTP reverse
proxy and forwarding tool with a genuinely friendly web UI. It handles virtual
hosts and virtual directories, automatic TLS via ACME/Let's Encrypt, access
control (geo-IP, whitelist/blacklist), redirects, a web SSH terminal, uptime
monitoring and more — a lightweight alternative to Nginx Proxy Manager.

This pack runs Zoraxy as a single host-networked Nomad service. Host networking
lets Zoraxy bind the ports it proxies (typically 80/443) on the node.

## Deploy

```bash
nomad-pack run zoraxy --registry=nomploy
```

Open `http://<node-ip>:8000` and create the admin account, then add your proxy
hosts.

## Configuration

| Variable        | Default                     | Description                                       |
| --------------- | --------------------------- | ------------------------------------------------- |
| `image`         | `zoraxydocker/zoraxy:latest`| Container image (pin a tag in production).            |
| `port`          | `8000`                      | Host port for the management UI.                   |
| `config_volume` | `zoraxy_config`             | Volume for config and certificates.                |
| `plugin_volume` | `zoraxy_plugin`             | Volume for plugins.                                |
| `resources`     | 500 MHz / 512 MB            | CPU and memory for the task.                        |

> **Ports:** Zoraxy binds the proxy ports (e.g. 80/443) itself at runtime via
> host networking. Deploy it on a node where those ports are free (not already
> taken by another ingress), and pin it there with `constraints`.

Configuration and certificates persist in `config_volume`.
