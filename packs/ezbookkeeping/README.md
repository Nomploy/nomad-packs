# ezbookkeeping

[ezBookkeeping](https://ezbookkeeping.mayswind.net) is a lightweight, self-hosted
**personal finance and bookkeeping** app — accounts, transactions, categories, budgets and
reports, with multi-currency support and a mobile-friendly UI (and a PWA).

This pack runs ezBookkeeping as a single host-networked Nomad job with SQLite storage —
no external database is required.

## Quick start

```sh
nomad-pack run ezbookkeeping --registry=nomploy
```

Then open `http://<node-ip>:8080` and create the first account.

## Configuration

| Variable | Default | Notes |
|----------|---------|-------|
| `port` | `8080` | Web UI host port |
| `secret_key` | *change me* | Auth token signing key — keep stable |

Change `secret_key` to a long random value before deploying anywhere real and keep it
stable across deploys.

Data persists in the `ezbookkeeping_data` (SQLite) and `ezbookkeeping_storage` (uploads)
named volumes. For MySQL/PostgreSQL instead of SQLite, or other options, override the
`EBK_*` environment variables per the ezBookkeeping configuration docs.
