app {
  url = "https://openbao.org"
}

pack {
  name        = "openbao"
  description = "OpenBao — an open-source (MPL-2.0) secrets manager forked from HashiCorp Vault: store, access, and distribute secrets, tokens, and certificates. Deployed as a host-networked Nomad service with file storage on a persistent volume. Requires a one-time initialize + unseal after first deploy."
  url         = "https://github.com/Nomploy/nomad-packs/tree/main/packs/openbao"
  version     = "0.1.0"
}
