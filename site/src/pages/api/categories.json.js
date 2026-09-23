// Static JSON facet index: every category with its pack count and ids, for fast
// client/panel filtering. Served at <base>/api/categories.json.
import { getPacks } from "../../lib/packs.js";

export async function GET() {
  const packs = await getPacks();
  const map = new Map();
  for (const p of packs) {
    if (!map.has(p.category)) map.set(p.category, []);
    map.get(p.category).push(p.id);
  }
  const categories = [...map.entries()]
    .map(([name, ids]) => ({ name, count: ids.length, ids: ids.sort() }))
    .sort((a, b) => a.name.localeCompare(b.name));

  const body = {
    generated: new Date().toISOString(),
    count: categories.length,
    total: packs.length,
    categories,
  };
  return new Response(JSON.stringify(body), {
    headers: {
      "content-type": "application/json; charset=utf-8",
      "access-control-allow-origin": "*",
    },
  });
}
