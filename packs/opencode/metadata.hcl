app {
  url = "https://opencode.ai"
}

pack {
  name        = "opencode"
  description = "OpenCode — an open-source AI coding agent, run in headless server mode: it exposes an HTTP API that the OpenCode TUI, editor extensions, and other clients connect to. Deployed as a single host-networked Nomad service with config and data volumes; bring an LLM provider key."
  url         = "https://github.com/Nomploy/nomad-packs/tree/main/packs/opencode"
  version     = "0.1.0"
}
