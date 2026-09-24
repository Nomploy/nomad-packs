# owntracks-recorder

[OwnTracks Recorder](https://owntracks.org/booklet/clients/recorder/) — a self-hosted store and web map
for your own location history. The [OwnTracks](https://owntracks.org) iOS/Android apps publish your
positions to it, and you keep a private, queryable timeline (REST API + built-in map) instead of handing
your movements to a cloud service.

Single host-networked Nomad service in **HTTP mode** (no MQTT broker needed) with a persistent data volume.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run owntracks-recorder --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `8083` | Web UI / API port. The container listens on 8083. |
| `data_volume` | `owntracks_store` | `/store` — the recorded location history. |
| `image` | `owntracks/recorder:latest` | Container image. Pin a tag in production. |
| `resources` | `{ cpu = 300, memory = 128 }` | Task resources. |

MQTT is disabled (`OTR_PORT=0`) so this runs standalone over HTTP. In the OwnTracks app, set **Mode =
HTTP** and point it at `http://<node-ip>:8083/pub?u=<user>&d=<device>`.

> The Recorder has **no built-in authentication** and stores sensitive location data — keep it on an
> internal network or front it with an authenticating reverse proxy. Pin the job to the node holding the
> volume with `constraints`.
