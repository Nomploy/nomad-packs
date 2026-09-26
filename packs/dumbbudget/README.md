# dumbbudget

[DumbBudget](https://github.com/DumbWareio/DumbBudget) — a stupidly simple **personal budget and expense tracker**.
Add income and expenses, categorize them, filter by date, and see totals — behind a simple PIN lock, with
multi-currency support. No accounts or cloud, just a tidy ledger that persists to disk.

Single host-networked Nomad service with a persistent data volume.

## Deploy

```sh
nomad-pack registry add nomploy https://github.com/Nomploy/nomad-packs
nomad-pack run dumbbudget --registry=nomploy
```

## Configure

| Variable | Default | Description |
| --- | --- | --- |
| `port` | `3000` | Web UI port (`PORT`). |
| `pin` | `""` | **Required.** PIN lock, 4–10 digits (`DUMBBUDGET_PIN`). Set your own — the app won't start without it. |
| `currency` | `USD` | ISO 4217 currency code (`CURRENCY`). |
| `base_url` | `""` | Public URL (`BASE_URL`). Empty = `http://localhost:<port>`. |
| `image` | `dumbwareio/dumbbudget:latest` | Container image. Pin a tag in production. |
| `data_volume` | `dumbbudget_data` | `/app/data` — the transactions database. |
| `resources` | `{ cpu = 300, memory = 256 }` | Task resources. |

> **Set a `pin`** before deploying — DumbBudget requires it and will not start otherwise. A prestart init task chowns
> the data volume to uid `1000`. Pin the job to the node holding the volume with `constraints`.
