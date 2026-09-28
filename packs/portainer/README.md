# portainer

[Portainer](https://www.portainer.io) is a lightweight, popular management UI
for container platforms. Its Community Edition gives you a clean web interface
to browse and control **containers, images, volumes, networks, stacks and
environments** on Docker (and Kubernetes/Swarm) — start/stop/inspect, view logs,
open a console, deploy stacks and manage users/teams.

This pack runs Portainer CE as a single host-networked Nomad service that
manages the Docker engine on its node.

## Deploy

```bash
nomad-pack run portainer --registry=nomploy
```

Open `https://<node-ip>:9443` and create the admin account (do this promptly —
Portainer disables initial setup after a timeout).

## Configuration

| Variable      | Default                         | Description                                    |
| ------------- | ------------------------------- | ---------------------------------------------- |
| `image`       | `portainer/portainer-ce:latest` | Container image (pin a tag in production).        |
| `port`        | `9443`                          | Host port for the HTTPS web UI.                 |
| `http_port`   | `9000`                          | Host port for the HTTP web UI.                  |
| `data_volume` | `portainer_data`                | Volume for Portainer data (`/data`).            |
| `docker_sock` | `/var/run/docker.sock`          | Docker socket to manage.                         |
| `resources`   | 300 MHz / 256 MB                | CPU and memory for the task.                     |

Portainer manages the Docker socket of the node it runs on — pin it there with
`constraints`. Settings, users and environments persist in `data_volume`.
