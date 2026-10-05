# certimate

[Certimate](https://certimate.trueme.io) is a self-hosted **SSL/TLS certificate manager**.
Request certificates from ACME CAs (Let's Encrypt, ZeroSSL, Google, …) with DNS or HTTP
challenges, auto-renew them, and deploy them to your servers, CDNs, load balancers and
cloud services — all from one dashboard.

This pack runs Certimate as a single host-networked Nomad job. It's built on PocketBase
and stores everything (its database, certificates and provider credentials) in the
`certimate_data` volume — no external database is required.

## Quick start

```sh
nomad-pack run certimate --registry=nomploy
```

Then open `http://<node-ip>:8090` and create the admin account.

## Configuration

| Variable | Default | Notes |
|----------|---------|-------|
| `port` | `8090` | Web UI host port |
| `data_volume` | `certimate_data` | Database + certificates + credentials |

## Security

Certimate stores API credentials for your DNS/hosting/cloud providers, so treat it as
sensitive: keep it behind your VPN or an authenticating reverse proxy, and back up the
`certimate_data` volume.
