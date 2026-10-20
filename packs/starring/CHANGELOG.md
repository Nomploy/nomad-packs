# Changelog

## 0.1.0

- Initial release. All-in-one host-networked job: Starring app + bundled
  PostgreSQL 17 on a persistent named volume, with the app gated on the database
  being ready (`prestart` wait task) to avoid a boot-time crash loop.
