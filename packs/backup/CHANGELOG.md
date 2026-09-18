# Changelog

## 0.1.0

- Initial release: scheduled restic backups as a periodic Nomad batch job. Mounts the
  listed Docker named volumes read-only, initializes the repository on first run, snapshots
  to an S3-compatible target, and prunes by a keep-daily/weekly/monthly policy. Configurable
  cron/time zone, repository, encryption password, S3 credentials, and retention.
