# checkcle

[CheckCle](https://checkcle.io) is a self-hosted **monitoring platform** — uptime checks
(HTTP, TCP, DNS, ping), SSL/TLS certificate-expiry monitoring, scheduled maintenance,
incident tracking and public status pages, with alerting to your channels.

This pack runs CheckCle as a single host-networked Nomad job (built on PocketBase). Its
database and state live in the `checkcle_data` volume (`/mnt/pb_data`) — no external
database is required.

## Quick start

```sh
nomad-pack run checkcle --registry=nomploy
```

Then open `http://<node-ip>:8090` and create the admin account.

## Configuration

| Variable | Default | Notes |
|----------|---------|-------|
| `port` | `8090` | Web UI host port |
| `data_volume` | `checkcle_data` | Database + state (PocketBase pb_data) |

Add monitors, alert channels and status pages from the UI. Data persists in the
`checkcle_data` named volume.
