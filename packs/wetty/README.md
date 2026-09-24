# wetty

[WeTTY](https://github.com/butlerx/wetty) — a **terminal in your browser**. It serves a web front-end that opens
an SSH session to a host over HTTP(S), so you can get a shell from any device without a native SSH client.

Single host-networked, **stateless** Nomad service that connects to an SSH server you specify.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run wetty --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `3011` | Web terminal port (`--port`). |
| `ssh_host` | `127.0.0.1` | SSH server to connect to (`--ssh-host`). |
| `ssh_port` | `22` | SSH server port (`--ssh-port`). |
| `ssh_user` | `""` | Pre-filled SSH username (`--ssh-user`); empty = prompt. |
| `image` | `wettyoss/wetty:latest` | Container image. Pin a tag in production. |
| `resources` | `{ cpu = 200, memory = 128 }` | Task resources. |

Open the URL and log in with your normal SSH credentials or keys. Point `ssh_host` at a reachable host (the
node itself, a bastion, etc.).

> **Security:** WeTTY exposes shell access over the web. Keep it **off the public internet** or behind an
> authenticating reverse proxy with TLS, and prefer SSH keys over passwords.
