# nginx-proxy-manager

[Nginx Proxy Manager](https://nginxproxymanager.com) — a friendly web UI for running Nginx as a
reverse proxy with free, automatic **Let's Encrypt** TLS. Add proxy hosts, redirects, streams, and
access lists without editing config files.

Host-networked, SQLite-backed, with data and certificate volumes.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run nginx-proxy-manager --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `http_port` / `https_port` | `80` / `443` | Proxied HTTP/HTTPS. |
| `admin_port` | `81` | Admin web UI. |
| `data_volume` | `npm_data` | `/data` — config + SQLite. |
| `letsencrypt_volume` | `npm_letsencrypt` | `/etc/letsencrypt` — certificates. |
| `image` | `jc21/nginx-proxy-manager:latest` | Image. Pin a tag in production. |
| `resources` | `{ cpu = 500, memory = 512 }` | Task resources. |

Default login is `admin@example.com` / `changeme` — **change it on first login**. For Let's Encrypt,
the domain's DNS must point at this node and ports 80/443 must be internet-reachable. Note: ports
80/443 overlap the `caddy` pack — run only one proxy per node. Pin with `constraints`.
