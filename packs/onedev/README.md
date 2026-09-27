# onedev

[OneDev](https://onedev.io/) — an all-in-one, self-hosted **Git server** with built-in **CI/CD**, code search &
navigation, pull requests, packages and Kanban boards. Unlike some forges it needs no separate CI runner to get
started and uses an **embedded database**, so a single container gives you a full development platform.

Single host-networked Nomad service with a persistent data volume.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run onedev --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `6610` | Web UI / HTTP-git port (OneDev's default). |
| `ssh_port` | `6611` | git-over-SSH port (OneDev's default). |
| `image` | `1dev/server:latest` | Container image. Pin a tag in production. |
| `data_volume` | `onedev_data` | `/opt/onedev` — repositories, embedded DB and config. |
| `resources` | `{ cpu = 1500, memory = 2048 }` | Task resources. The JVM needs headroom. |

> On first launch, complete the setup wizard (create the admin account, set the server URL). The default ports match
> OneDev's built-ins; a prestart init task makes the data volume writable. For CI builds on the same host, add a Docker
> executor by mounting `/var/run/docker.sock` into the task. Pin the job to the node holding the volume with
> `constraints`.
