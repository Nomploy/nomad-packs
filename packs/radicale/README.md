# radicale

[Radicale](https://radicale.org) — a lightweight CalDAV and CardDAV server. Self-host your
calendars and contacts and sync them across phones and desktops.

Single host-networked Nomad service with a rendered config, htpasswd auth, and a data volume. A
busybox prestart task chowns the data volume to Radicale's UID.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run radicale --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `5232` | CalDAV/CardDAV port. |
| `username` / `password` | `admin` / `changeme-please` | Sync login (htpasswd). **Change the password.** |
| `uid` | `2999` | User Radicale runs as; volume is chown'd to it. |
| `data_volume` | `radicale_data` | `/var/lib/radicale/collections`. |
| `image` | `rockstorm/radicale:latest` | Container image. Pin a tag in production. |
| `resources` | `{ cpu = 200, memory = 128 }` | Task resources. |

Add a CalDAV/CardDAV account on your device pointing at `http://<node-ip>:5232`. The users file
uses **plaintext** passwords for simplicity — for production switch `htpasswd_encryption` to
`bcrypt` (supply a hashed users file) and put TLS in front. Pin the job to the node holding the
volume with `constraints`.
