# Changelog

## 0.1.0

- Initial release: SeaweedFS as a single-node, host-networked Nomad service running
  `weed server -s3` (master + volume + filer + S3 gateway in one process), with a
  persistent Docker named volume for all state, configurable S3/master/volume/filer
  ports, optional S3 access-key/secret-key auth (rendered config; empty = open
  Allow-All), and Nomad service discovery on the S3 port.
