import { getPacks } from "../lib/packs.js";

// Hand-rolled sitemap: the @astrojs/sitemap integration trips over the JSON API
// endpoints, so we enumerate the real pages (home + one page per pack) here.
export async function GET({ site }) {
  const base = site ?? new URL("https://packs.nomploy.com");
  const packs = await getPacks();
  const now = new Date().toISOString().slice(0, 10);

  const urls = [
    { loc: new URL("/", base).href, priority: "1.0", changefreq: "daily" },
    ...packs.map((p) => ({
      loc: new URL(`/packs/${p.id}/`, base).href,
      priority: "0.8",
      changefreq: "weekly",
    })),
  ];

  const body =
    `<?xml version="1.0" encoding="UTF-8"?>\n` +
    `<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">\n` +
    urls
      .map(
        (u) =>
          `  <url><loc>${u.loc}</loc><lastmod>${now}</lastmod>` +
          `<changefreq>${u.changefreq}</changefreq><priority>${u.priority}</priority></url>`
      )
      .join("\n") +
    `\n</urlset>\n`;

  return new Response(body, {
    headers: { "Content-Type": "application/xml; charset=utf-8" },
  });
}
