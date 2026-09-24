# step-ca

[step-ca](https://smallstep.com/docs/step-ca/) — a small, self-hosted online certificate authority from
Smallstep. Run your own private PKI: issue short-lived X.509 (TLS) and SSH certificates, and use the
built-in **ACME** server so tools like Caddy, cert-manager, and certbot can obtain certificates from your
own CA.

Single host-networked Nomad service that **auto-initializes on first boot**, with a persistent volume for
its config, certificates, and keys.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run step-ca --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `9000` | CA HTTPS API port. |
| `ca_name` | `Nomploy CA` | Certificate authority name (`DOCKER_STEPCA_INIT_NAME`). |
| `dns_names` | `localhost` | Comma-separated DNS names/IPs the CA is reached at (`DOCKER_STEPCA_INIT_DNS_NAMES`). **Include this host.** |
| `ca_password` | `change-me-please` | Password protecting the CA keys (`DOCKER_STEPCA_INIT_PASSWORD`). **Change it** — used at init. |
| `data_volume` | `stepca_data` | `/home/step` — config, certs, and **private keys**. |
| `image` | `smallstep/step-ca:latest` | Container image. Pin a tag in production. |
| `resources` | `{ cpu = 300, memory = 256 }` | Task resources. |

After first boot, read the **root fingerprint** from the task logs, then bootstrap clients:

```sh
step ca bootstrap --ca-url https://<dns-name>:9000 --fingerprint <fingerprint>
```

Point ACME clients at `https://<dns-name>:9000/acme/acme/directory`. **Back up the `/home/step` volume
and the CA password securely** — they are the trust root of your PKI. Pin the job to the node holding the
volume with `constraints`.
