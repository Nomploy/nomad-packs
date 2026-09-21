app {
  url = "https://mailpit.axllent.org"
}

pack {
  name        = "mailpit"
  description = "Mailpit — a developer SMTP server that captures outgoing email into a web UI instead of delivering it, so you can test transactional mail safely. Deployed as a stateless host-networked Nomad service (messages held in memory)."
  url         = "https://github.com/Nomploy/nomad-packs/tree/main/packs/mailpit"
  version     = "0.1.0"
}
