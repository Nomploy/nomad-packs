# cryptpad

[CryptPad](https://cryptpad.org) is a privacy-first, **end-to-end encrypted**
collaborative office suite. It offers real-time collaborative rich text
documents, spreadsheets, presentations, forms, kanban boards, whiteboards, code
and markdown — all encrypted in the browser so the server has zero knowledge of
your content. A self-hosted alternative to Google Workspace / Office 365.

This pack runs CryptPad as a single host-networked Nomad service.

## Deploy

```bash
nomad-pack run cryptpad --registry=nomploy \
  --var main_domain=https://cryptpad.example.com \
  --var sandbox_domain=https://cryptpad-sandbox.example.com
```

Open the main app and register an account.

## Configuration

| Variable           | Default                    | Description                                        |
| ------------------ | -------------------------- | -------------------------------------------------- |
| `image`            | `cryptpad/cryptpad:latest` | Container image (pin a tag in production).            |
| `port`             | `3000`                     | Host port for the main app.                         |
| `sandbox_port`     | `3001`                     | Host port for the sandbox (different origin).        |
| `main_domain`      | `http://localhost:3000`    | Public URL of the main app.                          |
| `sandbox_domain`   | `http://localhost:3001`    | Public URL of the sandbox — **must differ** from main.|
| `data_volume` …    | `cryptpad_*`               | Volumes for data, blobs, blocks, datastore, customize.|
| `resources`        | 1000 MHz / 1024 MB         | CPU and memory for the task.                         |

> **Important:** CryptPad's security model requires the sandbox to be served from
> a **different origin** than the main application. Use two distinct
> domains/subdomains (or at least different ports) and route both through your
> reverse proxy. To become admin, register, then add your account's public key to
> the admin list in CryptPad's settings.

All content is end-to-end encrypted; the server stores only ciphertext, persisted
across the mounted volumes.
