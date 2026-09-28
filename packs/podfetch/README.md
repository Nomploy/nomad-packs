# podfetch

[PodFetch](https://podfetch.dev) is a self-hosted podcast manager and archiver.
Subscribe to shows (by RSS or via search), let it automatically download new
episodes, organise them, and stream everything from a clean web UI or a
podcast-app-compatible feed. It's a lightweight single binary backed by SQLite.

This pack runs PodFetch as a single host-networked Nomad service.

## Deploy

```bash
nomad-pack run podfetch --registry=nomploy --var server_url=http://<node-ip>:8000
```

Open `http://<node-ip>:8000` and add your first podcast.

## Configuration

| Variable           | Default                       | Description                                   |
| ------------------ | ----------------------------- | --------------------------------------------- |
| `image`            | `samuel19982/podfetch:latest` | Container image (pin a tag in production).        |
| `port`             | `8000`                        | Host port for the web UI.                      |
| `server_url`       | `http://localhost:8000`       | Public URL used in generated feed links.       |
| `polling_interval` | `60`                          | Minutes between subscription checks.           |
| `podcasts_volume`  | `podfetch_podcasts`           | Volume for downloaded episodes (`/app/podcasts`).|
| `db_volume`        | `podfetch_db`                 | Volume for the SQLite database (`/app/db`).     |
| `resources`        | 500 MHz / 512 MB              | CPU and memory for the task.                    |

Episodes and the database persist across restarts. PodFetch is open by default;
enable authentication with the `BASIC_AUTH`/OIDC environment variables if it's
reachable beyond a trusted network.
