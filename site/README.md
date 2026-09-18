# Registry web UI

A self-contained static site that browses this pack registry. It scans every pack's
`metadata.hcl`, `variables.hcl`, and `README.md`, and renders a searchable catalog with a
per-pack detail view (variables table + rendered readme + copy-paste run command).

## Build locally

```sh
node site/build.mjs          # writes site/dist/index.html (zero dependencies)
cd site/dist && python3 -m http.server 8099   # then open http://127.0.0.1:8099
```

Open `site/dist/index.html` directly too — all pack data is inlined; only the Markdown
renderer (`marked`) loads from a CDN, and there's a plain-text fallback if it's blocked.

## Deploy

`.github/workflows/pages.yml` rebuilds and publishes to **GitHub Pages** on every push to
`master` that touches `packs/**` or `site/**`. It needs Pages set to the **GitHub Actions**
source once (repo Settings → Pages → Build and deployment → Source: GitHub Actions).

The published URL is `https://nomploy.github.io/nomad-packs/`.
