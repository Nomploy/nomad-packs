# mysql

[MySQL](https://www.mysql.com) — the world's most popular open-source relational database (Oracle's
official build). Use this when an app specifically requires Oracle MySQL; otherwise the
[mariadb](../mariadb) pack is a lighter drop-in.

Host-networked Nomad service with a persistent Docker volume.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run mysql --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `3306` | Listen port. |
| `database` / `username` / `password` | `app` / `app` / `mysql` | Initial DB + app user. **Change the password.** |
| `root_password` | `mysql` | Root password. **Change it.** |
| `data_volume` | `mysql_data` | `/var/lib/mysql`. |
| `image` | `mysql:8` | Container image. Pin a tag in production. |
| `resources` | `{ cpu = 500, memory = 512 }` | Task resources. |

Pin the job to the node holding the volume with `constraints`.
