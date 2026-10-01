# stalwart

[Stalwart](https://stalw.art) is a modern, all-in-one mail server written in
Rust. One binary speaks **SMTP, IMAP, JMAP and POP3**, with a web admin,
built-in spam/phishing filtering, DKIM/SPF/DMARC/ARC, encryption at rest,
full-text search, sieve scripting and ACME TLS — a self-hosted alternative to
heavyweight mail stacks like Mailcow or a Postfix/Dovecot combo.

This pack runs Stalwart as a single host-networked Nomad service.

## Deploy

```bash
nomad-pack run stalwart --registry=nomploy \
  --var admin_password=$(openssl rand -hex 16)
```

Open `http://<node-ip>:8080` and log in as `admin`. On first start Stalwart is in
bootstrap mode — add your domain, accounts and TLS/DNS from the admin UI.

## Configuration

| Variable         | Default                       | Description                                   |
| ---------------- | ----------------------------- | --------------------------------------------- |
| `image`          | `stalwartlabs/stalwart:latest`| Container image (pin a tag in production).        |
| `admin_port`     | `8080`                        | Web admin / setup / HTTP(JMAP) port.           |
| `admin_user`     | `admin`                       | Recovery admin username.                        |
| `admin_password` | `stalwart_change_me`          | Recovery admin password — **change this**.      |
| `smtp_port` …    | `25/587/465/143/993/4190`     | SMTP / submission / IMAP / Sieve ports.         |
| `data_volume`    | `stalwart_data`               | Volume for config, data, queue (`/opt/stalwart`).|
| `resources`      | 1000 MHz / 1024 MB            | CPU and memory for the task.                     |

> **Running a mail server** means public DNS (MX, SPF, DKIM, DMARC), a static IP
> with clean reverse DNS, and open ports 25/465/587/993. Pin this job to the node
> that owns your mail hostname's public IP (`constraints`). All state persists in
> `data_volume`.
