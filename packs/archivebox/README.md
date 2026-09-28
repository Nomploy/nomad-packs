# archivebox

[ArchiveBox](https://archivebox.io) is a powerful, self-hosted web archiving
tool. Feed it URLs, browser bookmarks or RSS feeds and it saves complete,
permanent snapshots in many formats at once — original HTML, a readable article,
PDF, screenshot, WARC, media (via yt-dlp), git repos and more — building your own
private, searchable copy of the web that outlives link rot.

This pack runs ArchiveBox as a single host-networked Nomad service.

## Deploy

```bash
nomad-pack run archivebox --registry=nomploy \
  --var admin_password=$(openssl rand -hex 12) \
  --var csrf_trusted_origins=http://<node-ip>:8000
```

Open `http://<node-ip>:8000` and log in, then start adding URLs.

## Configuration

| Variable               | Default                       | Description                                  |
| ---------------------- | ----------------------------- | -------------------------------------------- |
| `image`                | `archivebox/archivebox:latest`| Container image (pin a tag in production).       |
| `port`                 | `8000`                        | Host port for the web UI.                     |
| `admin_user`           | `admin`                       | Admin username created on first start.        |
| `admin_password`       | `archivebox_change_me`        | Admin password — **change this**.             |
| `csrf_trusted_origins` | `http://localhost:8000`       | Origin(s) allowed for admin login.            |
| `data_volume`          | `archivebox_data`             | Volume for the archive and index (`/data`).   |
| `resources`            | 1000 MHz / 2048 MB            | CPU and memory (headless Chrome wants memory).|

The full archive, index database and config persist in `data_volume`.
