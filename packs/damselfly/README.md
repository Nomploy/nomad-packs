# damselfly

[Damselfly](https://github.com/Webreaper/Damselfly) is a server-based digital
asset manager (DAM) built for very large collections of images — tens or
hundreds of thousands of photos. It offers fast search, AI-powered object and
face recognition, keyword tagging, basic editing and export, and a responsive
web UI, all backed by SQLite so there's no external database to run.

This pack runs Damselfly as a single host-networked Nomad service.

## Deploy

```bash
nomad-pack run damselfly --registry=nomploy
```

Open `http://<node-ip>:6363`. Point the `/pictures` volume at your photo
library (or copy photos into it); Damselfly indexes the entire directory tree.

## Configuration

| Variable          | Default                     | Description                                    |
| ----------------- | --------------------------- | ---------------------------------------------- |
| `image`           | `webreaper/damselfly:latest`| Container image (pin a tag in production).      |
| `port`            | `6363`                      | Host port for the web UI.                       |
| `config_volume`   | `damselfly_config`          | Volume for the SQLite database and config.      |
| `thumbs_volume`   | `damselfly_thumbs`          | Volume for generated thumbnails.                |
| `pictures_volume` | `damselfly_pictures`        | Volume for the photo library root (`/pictures`).|
| `resources`       | 1000 MHz / 2048 MB          | CPU and memory (AI recognition wants memory).   |

A prestart init task fixes ownership on the volumes so Damselfly can write.
The database, thumbnails and library persist across restarts and upgrades.
