# sftpgo

[SFTPGo](https://github.com/drakkan/sftpgo) — a fully featured, self-hosted **SFTP, FTP/S and WebDAV server** with a
web admin UI. Manage users and folders, set per-user quotas and bandwidth limits, use virtual/shared folders, and
back accounts with local disk or object storage. Great for giving people or apps a secure file drop without exposing
system accounts.

Single host-networked Nomad service exposing HTTP (admin/client UI) and SFTP, with persistent data and config volumes.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run sftpgo --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `8080` | Web admin / client UI port (`SFTPGO_HTTPD__BINDINGS__0__PORT`). |
| `sftp_port` | `2022` | SFTP service port (`SFTPGO_SFTPD__BINDINGS__0__PORT`). |
| `image` | `drakkan/sftpgo:latest` | Container image. Pin a tag in production. |
| `data_volume` | `sftpgo_data` | `/srv/sftpgo` — persistent data and per-user home directories. |
| `home_volume` | `sftpgo_home` | `/var/lib/sftpgo` — config, SQLite database and SSH host keys. |
| `resources` | `{ cpu = 300, memory = 256 }` | Task resources. |

> **First run:** open `http://<host>:8080/web/admin` and create the admin account, then add users. A prestart init
> task chowns both volumes to uid `1000` (SFTPGo runs unprivileged). Point clients at the SFTP port (`2022`). Pin the
> job to the node holding the volumes with `constraints`.
