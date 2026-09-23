import { getPacks } from "../lib/packs.js";

// RSS feed of recently added packs (newest first). Dates come from git history.
export async function GET({ site }) {
  const base = site ?? new URL("https://packs.nomploy.com");
  const packs = (await getPacks())
    .filter((p) => p.added)
    .sort((a, b) => new Date(b.added) - new Date(a.added))
    .slice(0, 50);

  const esc = (s) => String(s).replace(/[&<>]/g, (c) => ({ "&": "&amp;", "<": "&lt;", ">": "&gt;" }[c]));
  const items = packs.map((p) => {
    const url = new URL(`/packs/${p.id}/`, base).href;
    return [
      "    <item>",
      `      <title>${esc(p.name)} (${esc(p.category)})</title>`,
      `      <link>${url}</link>`,
      `      <guid isPermaLink="true">${url}</guid>`,
      `      <pubDate>${new Date(p.added).toUTCString()}</pubDate>`,
      `      <description>${esc(p.description)}</description>`,
      "    </item>",
    ].join("\n");
  });

  const xml = [
    '<?xml version="1.0" encoding="UTF-8"?>',
    '<rss version="2.0"><channel>',
    "  <title>Nomploy Nomad Packs — new packs</title>",
    `  <link>${base.href}</link>`,
    "  <description>Newly added packs in the Nomploy Nomad Pack registry.</description>",
    `  <lastBuildDate>${new Date().toUTCString()}</lastBuildDate>`,
    ...items,
    "</channel></rss>",
    "",
  ].join("\n");

  return new Response(xml, { headers: { "Content-Type": "application/rss+xml; charset=utf-8", "access-control-allow-origin": "*" } });
}
