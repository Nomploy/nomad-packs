# openbao

[OpenBao](https://openbao.org) — an open-source (MPL-2.0) **secrets manager** forked from
HashiCorp Vault: store and control access to tokens, passwords, certificates, and API keys,
with dynamic secrets, leasing, and an audit trail. Host-networked Nomad service with **file
storage** on a persistent volume.

## Usage

```sh
nomad-pack registry add nomploy github.com/Nomploy/nomad-packs
nomad-pack run openbao --registry nomploy
```

In nomploy: create a Compose service, type **Nomad Pack**, pack `openbao`, custom registry
`github.com/Nomploy/nomad-packs`, then Deploy.

## Required one-time setup (initialize + unseal)

OpenBao starts **sealed** and empty — you must initialize and unseal it once:

```sh
export BAO_ADDR=http://<node-ip>:8200
bao operator init          # prints 5 unseal keys + an initial root token
bao operator unseal        # run 3 times, each with a different unseal key
```

(Or do it in the web UI at `http://<node-ip>:8200/ui`.) **Save the unseal keys and root
token somewhere safe and separate** — without them the data is unrecoverable. After any
restart, OpenBao is sealed again and must be unsealed.

## Key variables

| Variable | Default | Notes |
|---|---|---|
| `image` | `openbao/openbao:latest` | Pin a tag in production. |
| `port` | `8200` | API / UI. |
| `data_volume` | `openbao_data` | Encrypted file storage. Back it up. |
| `constraints` | `[]` | Pin to a node so the local storage stays put. |
| `resources` | `cpu 300 / mem 256` | Lightweight. |

## Notes

- **Not one-click** — the init/unseal above is required by design (it's how Vault/OpenBao
  protect the master key).
- **Single node.** `count` is fixed to 1 (file storage on a local volume). Pin with
  `constraints`. For HA you'd use the `raft` storage backend with multiple nodes.
- `disable_mlock = true` is set so **no `IPC_LOCK` capability is needed**; on a dedicated
  host you may prefer mlock enabled (which requires the capability).
- Serves plain **HTTP** — front it with a reverse proxy for TLS before storing anything real.
