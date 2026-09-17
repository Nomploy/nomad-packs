# gitea

[Gitea](https://about.gitea.com) — a lightweight, self-hosted Git service: repositories,
issues, pull requests, Gitea Actions (CI), and a **built-in container/package registry**.
A natural companion to the `zot` pack for a self-hosted dev platform.

Deployed as a host-networked Nomad service with a persistent Docker volume. It uses the
**bundled SQLite** database, so there's no external dependency — ideal for a single node.

## Usage

```sh
nomad-pack registry add nomploy github.com/Nomploy/nomad-packs
nomad-pack run gitea --registry nomploy
```

In nomploy: create a Compose service, type **Nomad Pack**, pack `gitea`, custom registry
`github.com/Nomploy/nomad-packs`, then Deploy.

Open `http://<node-ip>:3002`. The first visit shows the install page (pre-filled with the
SQLite defaults) — click **Install Gitea**, then register. The **first registered user
becomes the site admin.**

## Ports

- **HTTP** — `3002` (web UI + HTTP git). Defaulted off `3000`/`3001` to avoid the panel and
  grafana.
- **SSH** — `2222` (git over SSH). Gitea both listens here and advertises it in SSH clone
  URLs, so `git clone ssh://git@<node-ip>:2222/user/repo.git` works.

## Key variables

| Variable | Default | Notes |
|---|---|---|
| `image` | `gitea/gitea:1` | Pin a tag in production. |
| `http_port` | `3002` | Web UI / HTTP git. |
| `ssh_port` | `2222` | Git over SSH (avoid 22 — the host's sshd). |
| `root_url` | `""` | Public base URL when fronted by a domain (fixes HTTP clone links/webhooks). |
| `ssh_domain` | `""` | Hostname shown in SSH clone URLs. |
| `data_volume` | `gitea_data` | Repos + SQLite DB + config. Back it up. |
| `constraints` | `[]` | Pin to a node so the local volume stays put. |
| `resources` | `cpu 500 / mem 512` | Raise for heavier use. |

## Notes

- **Single node.** `count` is fixed to 1 (SQLite + repos on a local volume). Pin it with
  `constraints`. For scale/HA, switch to an external Postgres and shared storage.
- **Container registry:** built in — `docker login <node-ip>:3002` then push
  `<node-ip>:3002/<owner>/<image>`. (Plain HTTP: add it to each node's insecure-registries,
  or front Gitea with TLS.)
- **Backups:** snapshot the `data_volume` (or use `gitea dump`).
