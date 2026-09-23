# gotenberg

[Gotenberg](https://gotenberg.dev) — a developer-friendly, stateless API for generating PDFs.
Convert HTML, Markdown, URLs, and Office documents (via Chromium and LibreOffice), merge PDFs,
add screenshots, and more — all over a simple HTTP API.

Single host-networked Nomad service. **Stateless** (no volumes), so you can raise `count` and run
several instances behind a load balancer.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run gotenberg --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `3015` | API port (`--api-port`). |
| `count` | `1` | Instances to run (stateless — safe to scale). |
| `image` | `gotenberg/gotenberg:8` | Container image. Pin a tag in production. |
| `resources` | `{ cpu = 1000, memory = 1024 }` | Task resources. Conversions can spike CPU/RAM. |

Example — render a URL to PDF:

```sh
curl --request POST http://<node-ip>:3015/forms/chromium/convert/url \
  --form url=https://example.com -o out.pdf
```

The API has **no authentication** — keep it on an internal network or behind a reverse proxy, and
point apps like paperless-ngx or Docmost at it for document conversion.
