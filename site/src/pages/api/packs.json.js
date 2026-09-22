// Static JSON index of every pack — meant for programmatic use (e.g. the nomploy
// panel powering a fast "available packs" search without cloning/parsing the repo).
// Served at <base>/api/packs.json. Omits the readme bodies to keep it small; fetch
// /api/packs/<id>.json for a pack's full detail.
import { getPacks, REGISTRY_URL, REPO_URL } from "../../lib/packs.js";

export async function GET() {
  const packs = (await getPacks()).map(({ readme, readmeHtml, iconSvg, starsLabel, ...rest }) => rest);
  const body = {
    registry: REGISTRY_URL,
    repo: REPO_URL,
    generated: new Date().toISOString(),
    count: packs.length,
    packs,
  };
  return new Response(JSON.stringify(body), {
    headers: {
      "content-type": "application/json; charset=utf-8",
      "access-control-allow-origin": "*",
    },
  });
}
