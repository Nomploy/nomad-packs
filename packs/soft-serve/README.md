# soft-serve

[Soft Serve](https://github.com/charmbracelet/soft-serve) — a self-hostable **Git server** with a delightful SSH TUI
(from Charm). Browse repositories, read READMEs and commits, and manage access right in your terminal over SSH, push and
pull over SSH/HTTP/git, and keep everything on your own box. A lightweight, no-web-account alternative to a full forge.

Single host-networked Nomad service exposing SSH, HTTP, the git daemon and a stats endpoint, with a persistent data
volume.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run soft-serve --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `23231` | SSH port — the primary interface (TUI + push). |
| `http_port` | `23232` | HTTP browsing / git-over-HTTP clone. |
| `git_port` | `9418` | Anonymous `git://` daemon. |
| `stats_port` | `23233` | Prometheus metrics. |
| `admin_keys` | `""` | **Set this.** SSH public key(s) granted admin (`SOFT_SERVE_INITIAL_ADMIN_KEYS`). |
| `image` | `charmcli/soft-serve:latest` | Container image. Pin a tag in production. |
| `data_volume` | `soft_serve_data` | `/soft-serve` — repositories, config and host keys. |
| `resources` | `{ cpu = 300, memory = 256 }` | Task resources. |

> **Set `admin_keys`** to your SSH public key(s) before deploying, or you won't be able to administer the server. Then
> `ssh -p 23231 <host>` opens the TUI. Pin the job to the node holding the volume with `constraints`.
