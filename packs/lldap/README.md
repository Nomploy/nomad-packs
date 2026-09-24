# lldap

[LLDAP](https://github.com/lldap/lldap) — a light, opinionated LDAP server with a friendly web UI. It
gives you a simple, central directory of users and groups that dozens of apps can authenticate against
(Nextcloud, Gitea, Grafana, Authelia, Jellyfin, and more) — without the complexity of OpenLDAP.

Single host-networked Nomad service using **SQLite** with a persistent data volume.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run lldap --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `web_port` | `17170` | Web UI port (`LLDAP_HTTP_PORT`). |
| `ldap_port` | `3890` | LDAP protocol port (`LLDAP_LDAP_PORT`). |
| `base_dn` | `dc=example,dc=com` | LDAP base DN (`LLDAP_LDAP_BASE_DN`) — set to your domain. |
| `admin_password` | `change-me-please` | Password for the `admin` user (`LLDAP_LDAP_USER_PASS`). **Change it.** |
| `jwt_secret` | `change-me-…` | Session-token secret (`LLDAP_JWT_SECRET`). **Change it** (`openssl rand -hex 32`). |
| `data_volume` | `lldap_data` | `/data` — SQLite DB and private key. |
| `image` | `lldap/lldap:stable` | Container image. Pin a tag in production. |
| `resources` | `{ cpu = 200, memory = 128 }` | Task resources. |

Log in to the web UI as `admin`, create users/groups, then point apps at the LDAP endpoint (bind user
`uid=admin,ou=people,<base_dn>`). Serves plain LDAP/HTTP — keep it on an internal network or front the
web UI with a reverse proxy for TLS. Pin the job to the node holding the volume with `constraints`.
