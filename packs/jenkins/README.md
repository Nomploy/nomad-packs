# jenkins

[Jenkins](https://www.jenkins.io/) — the widely used open-source **automation server** for CI/CD. Build, test and deploy
with freestyle jobs or declarative Pipelines, distribute work to build agents, and extend it with a vast plugin
ecosystem. This pack runs the controller (LTS, JDK 17) with a persistent home.

Single host-networked Nomad service with a persistent `JENKINS_HOME` volume.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run jenkins --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `8080` | Web UI port (`--httpPort`). |
| `agent_port` | `50000` | Inbound JNLP build-agent port. |
| `image` | `jenkins/jenkins:lts-jdk17` | Container image. Pin a tag in production. |
| `data_volume` | `jenkins_data` | `/var/jenkins_home` — all Jenkins state. |
| `resources` | `{ cpu = 1000, memory = 1024 }` | Task resources. The JVM needs headroom; bump for busy controllers. |

> **First run:** the setup wizard needs the initial admin password, printed in the task logs (and at
> `/var/jenkins_home/secrets/initialAdminPassword`). A prestart init task chowns the home volume to uid `1000`. Run
> builds on agents rather than the controller for real workloads. Pin the job to the node holding the volume with
> `constraints`.
