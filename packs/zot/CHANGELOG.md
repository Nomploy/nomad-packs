# Changelog

## 0.1.0

- Initial zot pack: host-networked `service` job, local-disk storage with dedup +
  GC + untagged retention, anonymous-pull / authenticated-push via an optional
  `htpasswd`, config + htpasswd rendered from pack variables (no host files),
  pinnable via `constraints`.
