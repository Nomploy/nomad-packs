# Registry web UI

An [Astro](https://astro.build) static site that browses this pack registry. At build
time it scans every pack's `metadata.hcl`, `variables.hcl`, and `README.md`
(`src/lib/packs.js`) and generates a searchable catalog plus a static page per pack
(variables table + rendered readme + copy-paste run command).

## Develop

```sh
cd site
npm install
npm run dev       # http://localhost:4321/nomad-packs/
```

## Build

```sh
cd site
npm run build     # outputs site/dist/ (static)
npm run preview   # serve the build locally
```

Config lives in `astro.config.mjs` — `base: /nomad-packs` for the GitHub Pages project
subpath. Adding or editing a pack under `../packs/` is automatically picked up on the next
build; no code change needed here.

## Deploy

`.github/workflows/pages.yml` runs `npm ci && npm run build` and publishes `site/dist` to
**GitHub Pages** on every push to `master` touching `packs/**` or `site/**`.

One-time: repo Settings → Pages → Source = **GitHub Actions**. Published at
`https://nomploy.github.io/nomad-packs/`.
