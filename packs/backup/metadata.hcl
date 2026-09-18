app {
  url = "https://restic.net"
}

pack {
  name        = "backup"
  description = "Scheduled volume backups with restic — a periodic Nomad batch job that snapshots the Docker named volumes you list to an S3-compatible repository (e.g. the seaweedfs pack), with encryption and retention/pruning."
  url         = "https://github.com/Nomploy/nomad-packs/tree/main/packs/backup"
  version     = "0.1.0"
}
