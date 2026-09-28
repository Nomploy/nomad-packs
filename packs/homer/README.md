# homer

[Homer](https://github.com/bastienwirtz/homer) is a very simple, static
dashboard (start page) for your self-hosted services. There's no database and no
build step: you describe your services, groups and links in a single `config.yml`
and Homer renders a fast, good-looking static page with search, themes, custom
icons and optional service status/ping.

This pack runs Homer as a single host-networked Nomad service.

## Deploy

```bash
nomad-pack run homer --registry=nomploy
```

Open `http://<node-ip>:8080`. Homer seeds an example `config.yml` into the assets
volume on first run — edit it to add your own services.

## Configuration

| Variable        | Default            | Description                                   |
| --------------- | ------------------ | --------------------------------------------- |
| `image`         | `b4bz/homer:latest`| Container image (pin a tag in production).       |
| `port`          | `8080`             | Host port for the dashboard.                   |
| `assets_volume` | `homer_assets`     | Volume for `config.yml` and assets (`/www/assets`). |
| `resources`     | 100 MHz / 64 MB    | CPU and memory for the task.                    |

Your `config.yml`, custom icons and themes persist in `assets_volume`.
