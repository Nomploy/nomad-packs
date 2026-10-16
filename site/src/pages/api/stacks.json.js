// Static JSON index of every curated stack — a batteries-included bundle of packs
// that work well together on one node. Meant for programmatic use (the nomploy
// panel's "Deploy Stack" dialog lists these so a whole stack can be deployed in a
// couple of clicks, without the user hand-picking the packs). Served at
// <base>/api/stacks.json. Each stack is { id, name, tagline?, description?,
// packs: [packId], profiles?: [{ id, name, packs }] }.
import { getStacks } from "../../lib/stacks.js";
import { REGISTRY_URL, REPO_URL } from "../../lib/packs.js";

export async function GET() {
  const stacks = getStacks();
  const body = {
    registry: REGISTRY_URL,
    repo: REPO_URL,
    generated: new Date().toISOString(),
    count: stacks.length,
    stacks,
  };
  return new Response(JSON.stringify(body), {
    headers: {
      "content-type": "application/json; charset=utf-8",
      "access-control-allow-origin": "*",
    },
  });
}
