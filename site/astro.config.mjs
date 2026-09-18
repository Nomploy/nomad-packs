import { defineConfig } from "astro/config";

// Project site under https://nomploy.github.io/nomad-packs/
export default defineConfig({
  site: "https://nomploy.github.io",
  base: "/nomad-packs",
  trailingSlash: "always",
});
