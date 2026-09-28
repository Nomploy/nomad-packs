# anonymousoverflow

[AnonymousOverflow](https://github.com/httpjamesm/AnonymousOverflow) is a
privacy-respecting front-end for Stack Overflow and the wider Stack Exchange
network. It renders questions and answers without ads, trackers or the login
walls, in a clean, fast, readable layout — and pairs nicely with redirector
extensions like LibRedirect.

This pack runs AnonymousOverflow as a single host-networked Nomad service. It's
stateless.

## Deploy

```bash
nomad-pack run anonymousoverflow --registry=nomploy \
  --var app_url=https://ao.example.com \
  --var jwt_signing_secret=$(openssl rand -hex 24)
```

Open `http://<node-ip>:8080`.

## Configuration

| Variable             | Default                                        | Description                          |
| -------------------- | ---------------------------------------------- | ------------------------------------ |
| `image`              | `ghcr.io/httpjamesm/anonymousoverflow:latest`  | Container image (pin a tag).           |
| `port`               | `8080`                                         | Host port for the web UI.             |
| `app_url`            | `http://localhost:8080`                        | **Public URL** of the instance.       |
| `jwt_signing_secret` | placeholder                                    | JWT cookie secret — **change this**.  |
| `resources`          | 200 MHz / 128 MB                               | CPU and memory for the task.          |

AnonymousOverflow keeps no persistent state.
