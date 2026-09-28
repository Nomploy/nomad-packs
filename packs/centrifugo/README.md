# centrifugo

[Centrifugo](https://centrifugal.dev) is a scalable, language-agnostic real-time
messaging server. It sits next to your application and handles persistent
connections (WebSocket, SSE, HTTP-streaming, WebTransport, GRPC) so you can push
live updates — chat, notifications, dashboards, presence — to millions of
clients. Your backend simply publishes to channels over a straightforward
HTTP/GRPC API; clients subscribe with JWTs.

This pack runs Centrifugo as a single host-networked Nomad service with the admin
web UI enabled.

## Deploy

```bash
nomad-pack run centrifugo --registry=nomploy \
  --var admin_password=$(openssl rand -hex 12) \
  --var admin_secret=$(openssl rand -hex 16) \
  --var api_key=$(openssl rand -hex 16) \
  --var token_hmac_secret=$(openssl rand -hex 24)
```

Open `http://<node-ip>:8000` and log in with your admin password.

## Configuration

| Variable            | Default                    | Description                                    |
| ------------------- | -------------------------- | ---------------------------------------------- |
| `image`             | `centrifugo/centrifugo:v6` | Container image (pin a tag in production).        |
| `port`              | `8000`                     | Host port for HTTP + admin UI.                  |
| `admin_password`    | placeholder                | Admin UI password — **change this**.            |
| `admin_secret`      | placeholder                | Admin session secret — **change this**.         |
| `api_key`           | placeholder                | HTTP server API key — **change this**.          |
| `token_hmac_secret` | placeholder                | HMAC secret for client JWTs — **change this**.  |
| `resources`         | 500 MHz / 256 MB           | CPU and memory for the task.                     |

Centrifugo is stateless by default (no volume). For horizontal scaling or
history, configure a Redis engine via the additional `CENTRIFUGO_*` env vars.
