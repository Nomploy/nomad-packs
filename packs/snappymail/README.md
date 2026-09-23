# snappymail

[SnappyMail](https://snappymail.eu) — a fast, modern, lightweight webmail client for your
existing IMAP/SMTP mailboxes. Clean UI, low resource use, two-factor auth, and per-domain
configuration — a leaner alternative to Roundcube. It is a *client*, not a mail server: point it
at any IMAP/SMTP provider.

Single host-networked Nomad service with a persistent data/config volume.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run snappymail --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `8888` | Web UI port. The container's nginx is fixed at 8888 — keep this unless you also change the image config. |
| `upload_max_size` | `25M` | Max attachment upload size (`UPLOAD_MAX_SIZE`). |
| `data_volume` | `snappymail_data` | `/var/lib/snappymail` — config, domains, accounts. |
| `image` | `djmaze/snappymail:latest` | Container image. Pin a tag in production. |
| `resources` | `{ cpu = 300, memory = 256 }` | Task resources. |

**First run:** open the admin panel at `/?admin`. The generated admin password is written to
`_data_/_default_/admin_password.txt` inside the data volume (`nomad alloc fs` or `nomad alloc
exec` to read it). Log in, add your mail domain(s) with their IMAP/SMTP servers, then users sign
in at the main URL with their mailbox credentials. Serves plain HTTP — front it with a reverse
proxy for TLS. Pin the job to the node holding the volume with `constraints`.
