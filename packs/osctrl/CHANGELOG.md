# Changelog

## 0.1.0

- Initial osctrl pack: all-in-one osctrl-tls + osctrl-api + osctrl-frontend with
  bundled PostgreSQL and Redis. An init task (osctrl-cli) creates the environment
  and admin user on first boot. Frontend nginx config is rebound to a host port and
  proxies `/api` to the API over `127.0.0.1`.
