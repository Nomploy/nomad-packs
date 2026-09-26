# coredns

[CoreDNS](https://coredns.io/) — a fast, flexible, **plugin-based DNS server** (the default DNS in Kubernetes). This
pack ships it as a **caching forwarder** out of the box, and lets you drop in your own Corefile for split-horizon DNS,
local zones, hosts entries, ad-blocking and more.

Single host-networked Nomad service. The Corefile is generated from your variables (no volume needed).

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run coredns --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `53` | DNS port (TCP + UDP). |
| `upstreams` | `1.1.1.1 9.9.9.9` | Upstream resolvers the default Corefile forwards to. |
| `corefile` | `""` | Full custom Corefile contents. Empty = the generated caching-forwarder config. |
| `image` | `coredns/coredns:latest` | Container image. Pin a tag in production. |
| `resources` | `{ cpu = 300, memory = 256 }` | Task resources. |

> The default config forwards all queries to `upstreams`, caches, and enables `log`/`errors`/`health`. For anything
> richer (local zones with the `file`/`hosts` plugins, ad-blocking, per-domain routing), set `corefile` to your own
> Corefile. Port 53 must be free on the node — disable a host resolver (e.g. `systemd-resolved`) if it's bound there.
> Pin the job with `constraints` if clients target a specific node.
