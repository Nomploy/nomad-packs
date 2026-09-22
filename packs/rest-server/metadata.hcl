app {
  url = "https://github.com/restic/rest-server"
}

pack {
  name        = "rest-server"
  description = "Restic REST Server — a high-performance HTTP backend for restic backups, faster than restic's SFTP/S3 backends and able to run append-only so clients can't delete history. Deployed as a single host-networked Nomad service with a data volume for repositories. Pairs with the backup pack as its restic target."
  url         = "https://github.com/Nomploy/nomad-packs/tree/main/packs/rest-server"
  version     = "0.1.0"
}
