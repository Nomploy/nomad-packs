# remark42

[Remark42](https://remark42.com) is a lightweight, privacy-focused commenting
engine you can embed on any website or blog — a self-hosted alternative to
Disqus. It supports anonymous and social logins (GitHub, Google, Twitter,
Microsoft, Apple and more), threaded discussions, voting, moderation, email
notifications, image uploads and import/export. It's tiny: typically well under
100 MB of RAM.

This pack runs Remark42 as a single host-networked Nomad service backed by its
embedded BoltDB store.

## Deploy

```bash
nomad-pack run remark42 --registry=nomploy \
  --var remark_url=https://comments.example.com \
  --var secret=$(openssl rand -hex 24)
```

Then embed the widget on your pages (see the Remark42 docs for the script
snippet), pointing `host` at this instance and `site_id` at your `site`.

## Configuration

| Variable      | Default                  | Description                                    |
| ------------- | ------------------------ | ---------------------------------------------- |
| `image`       | `umputun/remark42:latest`| Container image (pin a tag in production).       |
| `port`        | `8080`                   | Host port.                                       |
| `remark_url`  | `http://localhost:8080`  | **Public URL** Remark42 is served from.          |
| `secret`      | placeholder              | Auth-token signing secret — **change this**.     |
| `site`        | `remark`                 | Site identifier the instance serves.             |
| `auth_anon`   | `true`                   | Allow anonymous commenting.                       |
| `data_volume` | `remark42_data`          | Volume for comments and backups (`/srv/var`).    |
| `resources`   | 200 MHz / 128 MB         | CPU and memory for the task.                      |

Comments and backups persist in `data_volume`. Enable social login and set
admins via the standard `AUTH_*` and `ADMIN_*` environment variables.
