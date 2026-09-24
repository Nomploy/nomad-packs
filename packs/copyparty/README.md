# copyparty

[copyparty](https://github.com/9001/copyparty) — a portable, feature-packed file server in a single
process. It speaks **HTTP, WebDAV, FTP, and TFTP**, with resumable/accelerated uploads, a slick file
browser, media indexing with thumbnails, audio streaming, dedup, and fine-grained per-path access control.

Single host-networked Nomad service serving a data volume, with a config volume for accounts and rules.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run copyparty --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `3923` | Web server port. |
| `share_mode` | `r` | Anonymous access to `/w`: `r` (read), `rw` (read+write), `w` (upload-only), `g` (get-only). |
| `data_volume` | `copyparty_data` | `/w` — the shared files. |
| `config_volume` | `copyparty_config` | `/cfg` — drop `.conf` files here for accounts and volumes. |
| `image` | `copyparty/ac:latest` | Container image (`ac` = all codecs; `copyparty/min` is smaller). Pin a tag. |
| `resources` | `{ cpu = 500, memory = 256 }` | Task resources. |

The `/w` volume is shared with the anonymous access level in `share_mode`. For **user accounts and
per-path permissions**, add a `.conf` file to the `/cfg` volume (see copyparty's example configs) — it is
picked up automatically and can override the CLI args. Serves plain HTTP — front it with a reverse proxy
for TLS or keep it internal. Pin the job to the node holding the volumes with `constraints`.
