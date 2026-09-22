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
`https://packs.nomploy.com/`.

## JSON API

The build also emits static JSON so other tools (e.g. the nomploy panel) can offer a fast
"available packs" search without cloning or parsing the registry:

- **`/api/packs.json`** — index of every pack: `id`, `name`, `description`, `version`,
  `category`, `sourceUrl`, `appUrl`, `runCommand`, `variables`, and `icon` (either
  `{kind:"brand",slug,hex,title}` for a simple-icons glyph or `{kind:"monogram",text,color}`)
  — readme bodies omitted to keep it small. One fetch powers client-side search.
- **`/api/packs/<id>.json`** — full detail for one pack, adding `readme` (raw markdown) and
  `readmeHtml` (rendered).

Both are plain static files served by GitHub Pages (which sends `Access-Control-Allow-Origin: *`),
so they're fetchable from the browser or server-side:

```
https://packs.nomploy.com/api/packs.json
https://packs.nomploy.com/api/packs/redis.json
```

The data comes straight from `src/lib/packs.js`, so adding a pack updates the API on the
next deploy with no extra work.
