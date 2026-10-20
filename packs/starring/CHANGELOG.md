# Changelog

## 0.1.1

- Fix: the `wait-db` prestart task now runs with `network_mode = "host"` so it
  shares the host loopback with the host-networked PostgreSQL. Without it the task
  probed its own container loopback and never saw the database, so the gate timed
  out instead of releasing the app.

## 0.1.0

- Initial release. All-in-one host-networked job: Starring app + bundled
  PostgreSQL 17 on a persistent named volume, with the app gated on the database
  being ready (`prestart` wait task) to avoid a boot-time crash loop.
