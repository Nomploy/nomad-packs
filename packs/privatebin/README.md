# privatebin

[PrivateBin](https://privatebin.info) is a minimalist, open-source online
pastebin where the **server has zero knowledge** of the data being pasted.
Content is encrypted and decrypted in the browser using 256-bit AES; the
server only ever stores ciphertext. It supports password-protected pastes,
configurable expiration, optional discussions, file/image attachments and
burn-after-reading.

This pack runs the PrivateBin all-in-one image (Nginx + php-fpm) as a single
host-networked Nomad service with file-based storage.

## Deploy

```bash
nomad-pack run privatebin --registry=nomploy
```

Open `http://<node-ip>:8080` and start pasting.

## Configuration

| Variable      | Default                                | Description                                  |
| ------------- | -------------------------------------- | -------------------------------------------- |
| `image`       | `privatebin/nginx-fpm-alpine:stable`   | All-in-one image (pin a tag in production).    |
| `port`        | `8080`                                 | Host port for the web UI.                     |
| `data_volume` | `privatebin_data`                      | Volume for paste storage (`/srv/data`).        |
| `resources`   | 300 MHz / 256 MB                       | CPU and memory for the task.                   |

A prestart init task fixes ownership on the data volume. To customise settings,
mount a `conf.php` at `/srv/cfg/conf.php` (see the PrivateBin configuration
docs). Pastes persist in `data_volume`.
