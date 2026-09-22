# glances

[Glances](https://nicolargo.github.io/glances/) — a cross-platform system monitor with a live
web dashboard (CPU, memory, disk, network, processes, Docker containers) and a REST API.

Stateless, host-networked Nomad service. Runs with `pid_mode = host` so stats reflect the whole
node, and (by default) mounts the Docker socket read-only for per-container stats.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run glances --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `61208` | Web dashboard / REST API port. |
| `docker_socket` | `true` | Mount `/var/run/docker.sock:ro` for container stats. |
| `image` | `nicolargo/glances:latest-full` | Image (`-full` includes the web UI + all sensors). |
| `resources` | `{ cpu = 300, memory = 256 }` | Task resources. |

A lightweight at-a-glance view of a single node (whichever one the alloc lands on). For
multi-node history and alerting, use the [monitoring](../monitoring) pack. Glances has no
built-in auth — front it with TLS/auth.
