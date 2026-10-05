# trek

[TREK](https://github.com/liketrek/TREK) is a self-hosted **travel and trip planner**
with real-time collaboration — itineraries, maps, places, and packing lists for your
trips.

This pack runs TREK as a single host-networked Nomad job. It stores everything in SQLite
(in the `trek_data` volume), with uploads in `trek_uploads` — no external database is
required.

## Quick start

```sh
nomad-pack run trek --registry=nomploy
```

Then open `http://<node-ip>:3000` and create the first account.

## Configuration

| Variable | Default | Notes |
|----------|---------|-------|
| `port` | `3000` | Web UI host port |
| `encryption_key` | *change me* | Encrypts stored integration keys — keep stable |
| `allowed_origins` | *(blank)* | CORS origins; set to your public URL in production |
| `timezone` | `UTC` | Container timezone |

Change `encryption_key` to a long random value before deploying anywhere real and keep it
stable across deploys. Optional integrations (OIDC/SSO, Unsplash, map/places API keys)
can be added later via environment — see the TREK docs.

Data persists in the `trek_data` and `trek_uploads` named volumes.
