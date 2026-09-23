# openspeedtest

[OpenSpeedTest](https://openspeedtest.com) — a free, self-hosted HTML5 network speed test. Measure
download, upload, ping, and jitter straight from the browser, with no Flash, Java, or client app.
Great for checking LAN/WAN throughput between your devices and a server.

Single host-networked Nomad service. **Stateless** — no volumes.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run openspeedtest --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `3018` | HTTP web UI port (`HTTP_PORT`). |
| `https_port` | `3019` | HTTPS web UI port (`HTTPS_PORT`). |
| `image` | `openspeedtest/latest:latest` | Container image. Pin a tag in production. |
| `resources` | `{ cpu = 500, memory = 128 }` | Task resources. |

Open `http://<node-ip>:3018`. For accurate results above ~1 Gbps use the **HTTPS** URL (needs
HTTP/2). Throughput is limited by the server's NIC and the network path, so run it on a well-connected
node and test from another device.
