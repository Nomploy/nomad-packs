# dagu

[Dagu](https://docs.dagu.cloud) is a local-first workflow engine and a modern
replacement for cron. You define workflows as **DAGs in declarative YAML** and
Dagu runs them — shell commands, Docker containers, Kubernetes Jobs, remote
commands over SSH and more — with a built-in web UI, scheduling, retries,
logging and notifications. It's a single self-contained binary: no external
database or message broker required.

This pack runs Dagu as a single host-networked Nomad service.

## Deploy

```bash
nomad-pack run dagu --registry=nomploy
```

Open `http://<node-ip>:8080` and create your first DAG.

## Configuration

| Variable      | Default                        | Description                                       |
| ------------- | ------------------------------ | ------------------------------------------------- |
| `image`       | `ghcr.io/dagucloud/dagu:latest`| Container image (pin a tag in production).           |
| `port`        | `8080`                         | Host port for the web UI.                          |
| `data_volume` | `dagu_data`                    | Volume for DAGs, logs and state (`/var/lib/dagu`). |
| `docker_sock` | `/var/run/docker.sock`         | Docker socket for container steps; `""` to disable. |
| `resources`   | 300 MHz / 256 MB               | CPU and memory for the task.                        |

> **Note:** The Docker socket lets DAG steps start containers directly on the
> host — grant it only on nodes you trust, or set `docker_sock=""`.

DAG definitions, run history and logs persist in `data_volume`.
