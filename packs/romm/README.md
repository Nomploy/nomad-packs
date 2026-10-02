# romm

[RomM](https://romm.app) is a self-hosted **ROM manager and player** — scan and organize
your retro game library, enrich it with artwork and metadata from IGDB / ScreenScraper /
LaunchBox / MobyGames, and play games straight from your browser.

This pack runs RomM **all-in-one** as a single host-networked Nomad job:

- **romm** — the RomM app (`rommapp/romm:latest`), which bundles its own Redis
- **mariadb** — bundled database (prestart sidecar)

All tasks share the host network and talk over `127.0.0.1`, so no mesh networking is
required. Database migrations run automatically on first start.

## Quick start

```sh
nomad-pack run romm --registry=nomploy
```

Then open `http://<node-ip>:8080` and create the first admin account.

## Configuration

| Variable | Default | Notes |
|----------|---------|-------|
| `port` | `8080` | Web UI host port |
| `db_password` | *change me* | RomM MariaDB user password |
| `db_root_password` | *change me* | MariaDB root password |
| `auth_secret_key` | `0000…` | Session signing key (`openssl rand -hex 32`) — keep stable |
| `igdb_client_id` / `igdb_client_secret` | *(blank)* | IGDB (Twitch) keys for metadata scraping |
| `library_volume` | `romm_library` | Where your ROMs live — point at a host path for real use |

Change every secret before deploying anywhere real, and keep `auth_secret_key` stable.

## Your ROM library

ROMs go under `/romm/library`, backed by `library_volume`. For real use, set
`library_volume` to a host path (a bind mount) that already holds your game files, laid
out as RomM expects (`library/roms/<platform>/...`). See the RomM docs for the folder
structure.

## Metadata providers

Set `igdb_client_id` and `igdb_client_secret` (from a Twitch developer app) to enable
IGDB scraping. Other providers (ScreenScraper, SteamGridDB, RetroAchievements) can be
added later via their own environment variables.

Data persists in the `romm_db_data`, `romm_resources`, `romm_assets`, `romm_config`,
`romm_redis_data` and `romm_library` named volumes.
