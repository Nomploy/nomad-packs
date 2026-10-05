# yamtrack

[Yamtrack](https://github.com/FuzzyGrim/Yamtrack) is a self-hosted **media tracker** for
movies, TV, anime, manga, video games and books — a Trakt / Simkl alternative. Track what
you watch and play, with ratings, progress and statistics.

This pack runs Yamtrack **all-in-one** as a single host-networked Nomad job:

- **yamtrack** — the app and web UI (`ghcr.io/fuzzygrim/yamtrack:latest`), SQLite storage
- **redis** — bundled task queue (prestart sidecar)

Both share the host network and talk over `127.0.0.1`, so no mesh networking is required.
Database migrations run automatically on first start.

## Quick start

```sh
nomad-pack run yamtrack --registry=nomploy
```

Then open `http://<node-ip>:8000` and create the first account.

## Configuration

| Variable | Default | Notes |
|----------|---------|-------|
| `port` | `8000` | Web UI host port |
| `secret` | *change me* | Session signing key — keep stable |
| `redis_port` | `6379` | Bundled Redis (loopback) |

Change `secret` to a long random value before deploying anywhere real and keep it stable.
Add a TMDB / IGDB / MyAnimeList API key in the app settings to enable metadata lookups.
Data persists in the `yamtrack_db` named volume.
