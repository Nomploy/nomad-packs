app {
  url = "https://smallstep.com/docs/step-ca/"
}

pack {
  name        = "step-ca"
  description = "step-ca — a small, self-hosted online certificate authority from Smallstep. Run your own private PKI and issue short-lived TLS/SSH certificates, with a built-in ACME server so tools like Caddy and cert-manager can get certs from you. Deployed as a host-networked Nomad service that auto-initializes on first boot, with a persistent volume."
  url         = "https://github.com/Nomploy/nomad-packs/tree/main/packs/step-ca"
  version     = "0.1.0"
}
