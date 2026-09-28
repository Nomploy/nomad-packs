# photoview

[Photoview](https://photoview.github.io/) is a simple and user-friendly photo
gallery for people who keep their photos on their own server. It builds on top of
your existing directory of photos, adding a fast web UI with a timeline, albums,
map view, RAW support, video and **face recognition** — without moving or
modifying your originals.

This pack runs Photoview as a single host-networked Nomad service using its
built-in **SQLite** database, so there's no separate DB to run.

## Deploy

```bash
nomad-pack run photoview --registry=nomploy
```

Open `http://<node-ip>:8000`, create the initial user, then add a media path
pointing at `/photos`.

## Configuration

| Variable       | Default                     | Description                                    |
| -------------- | --------------------------- | ---------------------------------------------- |
| `image`        | `photoview/photoview:latest`| Container image (pin a tag in production).        |
| `port`         | `8000`                      | Host port for the web UI.                       |
| `data_volume`  | `photoview_data`            | Volume for the SQLite DB and cache (`/app/data`).|
| `media_volume` | `photoview_media`           | Volume for your photo library (`/photos`).      |
| `resources`    | 1000 MHz / 1024 MB          | CPU and memory (face recognition wants more).   |

Mount your existing photo library at `/photos` (read-only is fine). The database
and generated thumbnails persist in `data_volume`.
