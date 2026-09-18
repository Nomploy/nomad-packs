# cyberchef

[CyberChef](https://gchq.github.io/CyberChef/) — the "cyber swiss-army knife": a web app
for encryption/decryption, encoding, compression, and data analysis, built from hundreds of
composable operations you chain into a "recipe". Stateless host-networked Nomad service;
everything runs client-side.

## Usage

```sh
nomad-pack registry add nomploy github.com/Nomploy/nomad-packs
nomad-pack run cyberchef --registry nomploy
```

In nomploy: create a Compose service, type **Nomad Pack**, pack `cyberchef`, custom registry
`github.com/Nomploy/nomad-packs`, then Deploy.

Open `http://<node-ip>:8095`.

## Key variables

| Variable | Default | Notes |
|---|---|---|
| `image` | `mpepping/cyberchef:latest` | Pin a tag in production. |
| `port` | `8095` | Web app host port (rebinds nginx via a rendered config). |
| `count` | `1` | Stateless, so >1 is fine on distinct ports/nodes. |
| `resources` | `cpu 200 / mem 128` | Lightweight. |

## Notes

- **Stateless** — no volume; nothing to back up.
- All processing happens in your browser — handy for a self-hosted, offline CyberChef that
  keeps pasted data off third-party sites.
- The image serves via nginx internally; this pack renders a `server` block so it listens
  on `port`.
