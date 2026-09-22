import { defineConfig } from "astro/config";

// Served at the custom domain root: https://packs.nomploy.com/
export default defineConfig({
  site: "https://packs.nomploy.com",
  base: "/",
  trailingSlash: "always",
});
