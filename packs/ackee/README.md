# ackee

[Ackee](https://ackee.electerious.com) is a self-hosted, privacy-friendly
analytics tool for tracking website visitors. It's cookie-free and collects no
personal data (GDPR-friendly by design), while still giving you a clean dashboard
of views, referrers, devices, browsers and durations — plus a GraphQL API for
custom reporting.

This pack deploys Ackee **all-in-one** as a single host-networked Nomad job:
**MongoDB** (bundled as a prestart sidecar) plus the Ackee app.

## Deploy

```bash
nomad-pack run ackee --registry=nomploy \
  --var admin_password=$(openssl rand -hex 12)
```

Open `http://<node-ip>:3000`, log in, add your domain, and embed the tracking
snippet on your site.

## Configuration

| Variable         | Default                   | Description                                  |
| ---------------- | ------------------------- | -------------------------------------------- |
| `image`          | `electerious/ackee:latest`| App image (pin a tag in production).            |
| `mongo_image`    | `mongo:7.0`               | Bundled MongoDB (needs AVX for 5.0+).         |
| `port`           | `3000`                    | Host port for the web UI / API.               |
| `mongo_port`     | `27017`                   | Host port for MongoDB.                        |
| `admin_username` | `admin`                   | Ackee admin username.                         |
| `admin_password` | `ackee_change_me`         | Ackee admin password — **change this**.       |
| `resources`      | 300 MHz / 256 MB          | App task resources.                           |

Analytics data persists in the MongoDB volume.
