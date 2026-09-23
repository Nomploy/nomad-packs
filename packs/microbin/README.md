# microbin

[MicroBin](https://microbin.eu) — a tiny, feature-rich, self-contained pastebin and file-sharing web
app: share text and files with expiry, encryption, QR codes, and a built-in URL shortener.

Single host-networked Nomad service with a data volume.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run microbin --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `8109` | Web UI port (`MICROBIN_PORT`). |
| `public_url` | `""` | `MICROBIN_PUBLIC_PATH` for links/QR; empty = `http://localhost:<port>`. |
| `admin_username` / `admin_password` | `admin` / `changeme-please` | Admin login. **Change the password.** |
| `data_volume` | `microbin_data` | `/app/microbin_data` — pastas, files, database. |
| `image` | `danielszabo99/microbin:latest` | Image. Pin a tag in production. |
| `resources` | `{ cpu = 200, memory = 128 }` | Task resources. |

Set `public_url` to the URL you serve it on so shared links and QR codes resolve. See also the
[opengist](../opengist) pack (Git-powered gists). Pin the job to the node holding the volume with
`constraints`.
