# caddy

[Caddy](https://caddyserver.com) — a fast web server and reverse proxy with **automatic HTTPS**.

Host-networked Nomad service with a Caddyfile rendered from a variable and a `/data` volume that
persists ACME certificates.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run caddy --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `http_port` | `80` | HTTP port. |
| `https_port` | `443` | HTTPS port (auto-TLS with a domain). |
| `caddyfile` | a `:80` placeholder | The full Caddyfile — replace it. |
| `data_volume` | `caddy_data` | `/data` — ACME certificates and state. |
| `image` | `caddy:2` | Container image. Pin a tag in production. |
| `resources` | `{ cpu = 300, memory = 256 }` | Task resources. |

## Examples

Reverse proxy with automatic HTTPS (domain must resolve here, 80/443 reachable):

```
app.example.com {
  reverse_proxy 127.0.0.1:8096
}
```

Static file server:

```
:80 {
  root * /srv
  file_server
}
```

Certificates persist on the `data_volume`; pin the job to that node with `constraints`.
