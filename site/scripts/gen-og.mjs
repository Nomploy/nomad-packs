// Generate a per-pack Open Graph image (1200x630) so each pack link unfurls with
// its own branded card. Writes public/og/<id>.png (gitignored; regenerated each
// build). Pure JS via @resvg/resvg-js — no system dependencies.
import { mkdirSync, writeFileSync } from "node:fs";
import { dirname, join } from "node:path";
import { fileURLToPath } from "node:url";
import { Resvg } from "@resvg/resvg-js";
import { getPacks } from "../src/lib/packs.js";

const HERE = dirname(fileURLToPath(import.meta.url));
const OUT = join(HERE, "..", "public", "og");
mkdirSync(OUT, { recursive: true });

const esc = (s) => String(s || "").replace(/[&<>]/g, (c) => ({ "&": "&amp;", "<": "&lt;", ">": "&gt;" }[c]));
// wrap description to ~2 lines
function wrap(text, max, maxLines) {
  const words = String(text || "").split(/\s+/);
  const lines = [];
  let cur = "";
  for (const w of words) {
    if ((cur + " " + w).trim().length > max) { lines.push(cur.trim()); cur = w; if (lines.length === maxLines) break; }
    else cur = (cur + " " + w).trim();
  }
  if (lines.length < maxLines && cur) lines.push(cur.trim());
  return lines.slice(0, maxLines);
}

const packs = await getPacks();
let n = 0;
for (const p of packs) {
  const tileColor = p.icon.kind === "monogram" ? p.icon.color : (p.icon.hex || "#14B8A6");
  const letter = (p.name || p.id).slice(0, 1).toUpperCase();
  const ports = p.facts.ports.map((x) => x.port).join(" · ");
  const desc = wrap(p.description, 62, 2);
  const svg = `<svg xmlns="http://www.w3.org/2000/svg" width="1200" height="630" viewBox="0 0 1200 630">
  <defs>
    <linearGradient id="bg" x1="0" y1="0" x2="1" y2="1"><stop offset="0" stop-color="#0b1211"/><stop offset="1" stop-color="#121a19"/></linearGradient>
    <linearGradient id="bar" x1="0" y1="0" x2="1" y2="0"><stop offset="0" stop-color="#2DD4BF"/><stop offset="1" stop-color="#0EA5E9"/></linearGradient>
  </defs>
  <rect width="1200" height="630" fill="url(#bg)"/>
  <rect x="0" y="0" width="1200" height="8" fill="url(#bar)"/>
  <rect x="80" y="80" width="120" height="120" rx="26" fill="${esc(tileColor)}"/>
  <text x="140" y="162" font-family="Helvetica, Arial, sans-serif" font-size="68" font-weight="700" fill="#ffffff" text-anchor="middle">${esc(letter)}</text>
  <text x="228" y="132" font-family="Helvetica, Arial, sans-serif" font-size="34" fill="#93a5a1" letter-spacing="1">${esc((p.category || "").toUpperCase())}</text>
  <text x="226" y="185" font-family="Helvetica, Arial, sans-serif" font-size="60" font-weight="700" fill="#e6efec" letter-spacing="-1">${esc(p.name)}</text>
  <text x="80" y="290" font-family="Helvetica, Arial, sans-serif" font-size="34" fill="#c7d2cf">${esc(desc[0] || "")}</text>
  <text x="80" y="338" font-family="Helvetica, Arial, sans-serif" font-size="34" fill="#c7d2cf">${esc(desc[1] || "")}</text>
  ${ports ? `<text x="80" y="470" font-family="monospace" font-size="30" fill="#2DD4BF">ports: ${esc(ports)}</text>` : ""}
  <rect x="80" y="520" width="520" height="54" rx="12" fill="#172422" stroke="#223230"/>
  <text x="104" y="555" font-family="monospace" font-size="26" fill="#93a5a1">nomad-pack run ${esc(p.id)}</text>
  <text x="1120" y="560" font-family="monospace" font-size="24" fill="#5b6b68" text-anchor="end">packs.nomploy.com</text>
</svg>`;
  const png = new Resvg(svg, { fitTo: { mode: "width", value: 1200 } }).render().asPng();
  writeFileSync(join(OUT, `${p.id}.png`), png);
  n++;
}
console.log(`generated ${n} per-pack OG images -> public/og/`);
