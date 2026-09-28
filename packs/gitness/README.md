# gitness

[Harness Open Source](https://developer.harness.io/docs/open-source) (formerly
**Gitness**) is a self-hosted, all-in-one development platform: Git repository
hosting with pull requests and code review, **built-in CI/CD pipelines**,
artifact registries, a web IDE and more — all shipped as a single lightweight
binary with an embedded database. A lean alternative to running Gitea + a
separate CI system.

This pack runs it as a single host-networked Nomad service.

## Deploy

```bash
nomad-pack run gitness --registry=nomploy
```

Open `http://<node-ip>:3000` and create the admin account.

## Configuration

| Variable      | Default                 | Description                                          |
| ------------- | ----------------------- | ---------------------------------------------------- |
| `image`       | `harness/harness:latest`| Container image (pin a tag in production).              |
| `port`        | `3000`                  | Host port for the web UI / API.                       |
| `ssh_port`    | `3022`                  | Host port for Git over SSH.                            |
| `data_volume` | `gitness_data`          | Volume for the database and repositories (`/data`).   |
| `docker_sock` | `/var/run/docker.sock`  | Docker socket for CI/CD; set `""` to disable pipelines.|
| `resources`   | 1000 MHz / 1024 MB      | CPU and memory for the task.                           |

> **Note:** Mounting the Docker socket lets pipelines start containers directly
> on the host — grant it only on nodes you trust. Set `docker_sock=""` to run
> Gitness purely as a Git host without CI.

The database and repositories persist in `data_volume`.
