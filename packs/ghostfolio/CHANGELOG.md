# Changelog

## 0.1.0

- Initial release: Ghostfolio (self-hosted investment-portfolio tracker) as an all-in-one host-networked
  Nomad job — PostgreSQL and Redis prestart sidecars plus the Ghostfolio app, a persistent database
  volume, secrets via env (ACCESS_TOKEN_SALT / JWT_SECRET_KEY), and Nomad service discovery. Migrations
  run automatically on boot.
