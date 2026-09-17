# Changelog

## 0.1.0

- Initial release: Gitea as a host-networked Nomad service with a persistent Docker
  named volume for /data, HTTP and git-over-SSH on configurable host ports, optional
  ROOT_URL / SSH_DOMAIN for clone-URL correctness, and Nomad service discovery. Uses the
  bundled SQLite database for a zero-dependency single-node setup.
