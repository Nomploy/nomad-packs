app {
  url = "https://coder.com/docs/code-server"
}

pack {
  name        = "code-server"
  description = "code-server — run VS Code in the browser, on a remote machine. Deployed as a host-networked Nomad service with a persistent Docker volume for its config, extensions, and workspace, protected by a password."
  url         = "https://github.com/Nomploy/nomad-packs/tree/main/packs/code-server"
  version     = "0.1.0"
}
