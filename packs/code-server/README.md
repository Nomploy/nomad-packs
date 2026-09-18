# code-server

[code-server](https://coder.com/docs/code-server) — run **VS Code in the browser** on a
remote machine, so you can code from anything. Host-networked Nomad service with a
persistent volume for its config, extensions, and your files.

## Usage

```sh
nomad-pack registry add nomploy github.com/Nomploy/nomad-packs
nomad-pack run code-server --registry nomploy --var password=<a-strong-secret>
```

In nomploy: create a Compose service, type **Nomad Pack**, pack `code-server`, set
`password`, then Deploy.

Open `http://<node-ip>:8093` and log in with your password.

## Key variables

| Variable | Default | Notes |
|---|---|---|
| `image` | `codercom/code-server:latest` | Pin a tag in production. |
| `port` | `8093` | Web UI host port. |
| `password` | `changeme` | **Change this** — baked into the job env. |
| `data_volume` | `code_server_data` | `/home/coder` (config, extensions, files). Back it up. |
| `constraints` | `[]` | Pin to a node so the local volume stays put. |
| `resources` | `cpu 1000 / mem 1024` | Raise for heavier workloads. |

## Notes

- **Single node.** `count` is fixed to 1 (local volume). A prestart task chowns the volume
  to uid 1000 (the `coder` user). Pin with `constraints`.
- Serves plain HTTP — **front it with a reverse proxy for TLS** (you're editing code over
  it, so don't expose it unencrypted).
- **Backups:** snapshot the `data_volume`.
