# stirling-pdf

[Stirling-PDF](https://www.stirlingpdf.com) — a locally hosted web app with 50+ tools to
work with PDFs: merge, split, rotate, convert, OCR, sign, watermark, compress, and more.
Everything runs on your server — uploaded files aren't sent anywhere. Host-networked Nomad
service.

## Usage

```sh
nomad-pack registry add nomploy github.com/Nomploy/nomad-packs
nomad-pack run stirling-pdf --registry nomploy
```

In nomploy: create a Compose service, type **Nomad Pack**, pack `stirling-pdf`, custom
registry `github.com/Nomploy/nomad-packs`, then Deploy.

Open `http://<node-ip>:8096`.

## Key variables

| Variable | Default | Notes |
|---|---|---|
| `image` | `stirlingtools/stirling-pdf:latest` | Use a `-fat` tag for OCR/extra features. Pin in production. |
| `port` | `8096` | Web UI host port (`SERVER_PORT`). |
| `enable_login` | `false` | Turn on Stirling's login/user management. |
| `constraints` | `[]` | Placement. |
| `resources` | `cpu 1000 / mem 1024` | Raise memory for OCR / large PDFs. |

## Notes

- **Stateless** by default — no volume. (Optional `/configs`, `/usr/share/tessdata`, and
  `/pipeline` mounts enable custom settings, extra OCR languages, and automation; add them
  if you need those.)
- **Security:** with `enable_login` off it's open — keep it internal or front it with an
  authenticating reverse proxy.
