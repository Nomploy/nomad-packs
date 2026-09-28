# web-check

[Web-Check](https://web-check.xyz) is an all-in-one OSINT and website analysis
tool. Give it any URL and it returns a comprehensive dashboard: DNS records,
SSL/TLS chain, HTTP headers and security posture, detected technology stack,
open ports, cookies, crawl rules, carbon footprint, hosting/geo info,
performance and much more — great for auditing your own sites.

This pack runs Web-Check as a single host-networked Nomad service. It's
stateless (each report is generated on demand).

## Deploy

```bash
nomad-pack run web-check --registry=nomploy
```

Open `http://<node-ip>:3000` and enter a URL to analyse.

## Configuration

| Variable    | Default                    | Description                               |
| ----------- | -------------------------- | ----------------------------------------- |
| `image`     | `lissy93/web-check:latest` | Container image (pin a tag in production).    |
| `port`      | `3000`                     | Host port for the web UI.                  |
| `resources` | 500 MHz / 512 MB           | CPU and memory for the task.               |

Web-Check keeps no persistent state. A handful of checks can be enriched with
optional third-party API keys — add them via the relevant `*_API_KEY`
environment variables documented upstream.
