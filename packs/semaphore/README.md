# semaphore

[Semaphore UI](https://semaphoreui.com) — a modern web UI for infrastructure automation. Run and
schedule **Ansible** playbooks, **Terraform/OpenTofu**, and shell scripts; manage inventories,
repositories, and encrypted secrets; and give your team role-based access with a full run history.

Single host-networked Nomad service using the embedded **BoltDB** (no external database) with persistent
data and config volumes.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run semaphore --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `3000` | Web UI port. The container listens on 3000. |
| `admin_user` / `admin_password` | `admin` / `change-me-…` | Initial admin (`SEMAPHORE_ADMIN*`). **Change the password.** |
| `admin_name` / `admin_email` | `Admin` / `admin@nomploy.local` | Admin display name & email. |
| `access_key_encryption` | `change-me-…` | `SEMAPHORE_ACCESS_KEY_ENCRYPTION` — base64 32-byte key that encrypts stored secrets. **Change it and keep it stable** (`head -c32 /dev/urandom \| base64`). |
| `data_volume` | `semaphore_data` | `/var/lib/semaphore` — the BoltDB database and repositories. |
| `config_volume` | `semaphore_config` | `/etc/semaphore`. |
| `image` | `semaphoreui/semaphore:latest` | Container image. Pin a tag in production. |
| `resources` | `{ cpu = 500, memory = 512 }` | Task resources. |

Log in with your admin credentials, then set up a key store, repositories, inventory, and task
templates. **Keep `access_key_encryption` stable** — changing it makes stored secrets unreadable. Serves
plain HTTP — front it with a reverse proxy for TLS. Pin the job to the node holding the volumes with
`constraints`.
