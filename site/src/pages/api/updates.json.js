// Recently added/updated packs, newest first — for the panel or a changelog view.
import { getPacks } from "../../lib/packs.js";

export async function GET() {
  const packs = await getPacks();
  const recent = packs
    .filter((p) => p.added)
    .sort((a, b) => new Date(b.added) - new Date(a.added))
    .map((p) => ({ id: p.id, name: p.name, category: p.category, added: p.added, updated: p.updated }));
  const body = { generated: new Date().toISOString(), count: recent.length, packs: recent };
  return new Response(JSON.stringify(body), {
    headers: { "content-type": "application/json; charset=utf-8", "access-control-allow-origin": "*" },
  });
}
