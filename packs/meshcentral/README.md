# meshcentral

[MeshCentral](https://meshcentral.com) is a full, self-hosted remote monitoring
and management (RMM) server — a self-hosted alternative to TeamViewer/AnyDesk
and commercial RMMs. From a web browser you get **remote desktop, terminal and
file transfer**, wake-on-LAN, device grouping, two-factor auth and more, across
Windows, macOS and Linux agents.

This pack runs MeshCentral as a single host-networked Nomad service using its
built-in database (NeDB) — no external MongoDB required.

## Deploy

```bash
nomad-pack run meshcentral --registry=nomploy --var hostname=mesh.example.com
```

Open `https://<node-ip>:4430` (self-signed certificate) and create the first
account, which becomes the administrator.

## Configuration

| Variable             | Default                              | Description                                  |
| -------------------- | ------------------------------------ | -------------------------------------------- |
| `image`              | `ghcr.io/ylianst/meshcentral:latest` | Container image (pin a tag in production).      |
| `port`               | `4430`                               | Host port for the HTTPS web UI.               |
| `redir_port`         | `8081`                               | HTTP→HTTPS redirect port.                     |
| `hostname`           | `localhost`                          | **Public hostname/IP** used in agent config.  |
| `allow_new_accounts` | `false`                              | Allow self-registration after the first user. |
| `data_volume`        | `meshcentral_data`                   | Volume for config + embedded DB.              |
| `files_volume`       | `meshcentral_files`                  | Volume for user files.                         |
| `resources`          | 500 MHz / 512 MB                     | CPU and memory for the task.                   |

The HTTPS port defaults to `4430` (not the privileged `443`) to avoid clashing
with an ingress proxy. Set `hostname` to the address agents should connect to.
Config and the NeDB database persist in `data_volume`.
