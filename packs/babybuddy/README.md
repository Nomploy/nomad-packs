# babybuddy

[Baby Buddy](https://babybuddy.app) is a self-hosted **tracker for caregivers** — log a
baby's sleep, feedings, diaper changes, tummy time, pumping and more, with timers, charts
and daily summaries.

This pack runs Baby Buddy as a single host-networked Nomad job (the maintained LinuxServer
image) with SQLite storage in the `babybuddy_config` volume — no external database is
required.

## Quick start

```sh
nomad-pack run babybuddy --registry=nomploy
```

Then open `http://<node-ip>:8000` and sign in with the default account `admin` / `admin` —
change the password immediately.

## Configuration

| Variable | Default | Notes |
|----------|---------|-------|
| `port` | `8000` | Web UI host port |
| `csrf_trusted_origins` | `http://localhost:8000` | Add your public URL(s), comma-separated |
| `timezone` | `UTC` | Container timezone |
| `puid` / `pgid` | `1000` | File ownership on the config volume |

When serving Baby Buddy on a domain, add that URL to `csrf_trusted_origins` or form
submissions (login, logging entries) will be rejected. Data persists in the
`babybuddy_config` named volume.
