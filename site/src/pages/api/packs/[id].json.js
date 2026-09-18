// Static JSON detail for one pack — served at <base>/api/packs/<id>.json.
// Includes the full variable list plus the readme as raw markdown and rendered HTML.
import { getPacks } from "../../../lib/packs.js";

export function getStaticPaths() {
  return getPacks().map((pack) => ({ params: { id: pack.id }, props: { pack } }));
}

export function GET({ props }) {
  return new Response(JSON.stringify(props.pack), {
    headers: {
      "content-type": "application/json; charset=utf-8",
      "access-control-allow-origin": "*",
    },
  });
}
