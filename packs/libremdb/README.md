# libremdb

[libremdb](https://github.com/zyachel/libremdb) is a free, open-source,
privacy-respecting front-end for IMDb. It lets you look up movies, TV shows and
people — ratings, cast, plot, images and more — without IMDb's ads, trackers or
bulky client-side JavaScript, in a clean and fast interface.

This pack runs libremdb as a single host-networked Nomad service. It's stateless.

## Deploy

```bash
nomad-pack run libremdb --registry=nomploy
```

Open `http://<node-ip>:3000`.

## Configuration

| Variable    | Default                          | Description                               |
| ----------- | -------------------------------- | ----------------------------------------- |
| `image`     | `ghcr.io/zyachel/libremdb:latest`| Container image (pin a tag in production).    |
| `port`      | `3000`                           | Host port for the web UI.                  |
| `resources` | 300 MHz / 256 MB                 | CPU and memory for the task.               |

libremdb keeps no persistent state. For higher traffic you can optionally point
it at a Redis instance for caching via the `REDIS_URL` environment variable.
