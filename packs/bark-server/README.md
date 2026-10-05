# bark-server

[Bark](https://bark.day.app) is a free push-notification service for **iOS**; this pack
runs its self-hosted backend (`bark-server`). Send notifications to your iPhone from
scripts, cron jobs, monitoring and any service with a simple HTTP GET/POST.

This pack runs bark-server as a single host-networked Nomad job with a data volume for
device registrations — no external database is required.

## Quick start

```sh
nomad-pack run bark-server --registry=nomploy
```

Install the **Bark** app from the iOS App Store, set its server to
`http://<node-ip>:8080` (ideally a public HTTPS URL behind a reverse proxy), and it will
register a device key. Then:

```sh
curl http://<node-ip>:8080/<your-device-key>/Hello/World
```

## Configuration

| Variable | Default | Notes |
|----------|---------|-------|
| `port` | `8080` | HTTP API host port |
| `data_volume` | `bark_data` | Device-registration database |

iOS requires a reachable server URL to receive pushes, so for real use put bark-server
behind a reverse proxy with HTTPS. Data persists in the `bark_data` named volume.
