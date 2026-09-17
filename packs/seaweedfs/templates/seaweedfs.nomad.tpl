job "[[ var "job_name" . ]]" {
  namespace   = "[[ var "namespace" . ]]"
  datacenters = [[ var "datacenters" . | toStringList ]]
  type        = "service"

  [[- range $c := var "constraints" . ]]
  constraint {
    attribute = "[[ $c.attribute ]]"
    operator  = "[[ $c.operator ]]"
    value     = "[[ $c.value ]]"
  }
  [[- end ]]

  # Single-node all-in-one: `weed server -s3` runs the master, a volume server,
  # a filer and the S3 gateway in one process. count stays 1 — the data lives on
  # a local Docker volume. Scale out by running separate master/volume/filer
  # topologies instead (out of scope for this pack).
  group "[[ var "job_name" . ]]" {
    count = 1

    network {
      mode = "host"
      port "s3" {
        static = [[ var "s3_port" . ]]
      }
      port "master" {
        static = [[ var "master_port" . ]]
      }
      port "volume" {
        static = [[ var "volume_port" . ]]
      }
      port "filer" {
        static = [[ var "filer_port" . ]]
      }
    }

    service {
      name     = "[[ var "job_name" . ]]"
      provider = "nomad"
      port     = "s3"
    }

    restart {
      attempts = 3
      interval = "5m"
      delay    = "15s"
      mode     = "delay"
    }

    task "seaweedfs" {
      driver = "docker"

      config {
        image        = "[[ var "image" . ]]"
        network_mode = "host"
        ports        = ["s3", "master", "volume", "filer"]

        # Image entrypoint is `weed`; these are its args.
        args = [
          "server",
          "-s3",
          "-dir=/data",
          "-master.port=[[ var "master_port" . ]]",
          "-volume.port=[[ var "volume_port" . ]]",
          "-filer.port=[[ var "filer_port" . ]]",
          "-s3.port=[[ var "s3_port" . ]]",
          [[- if and (ne (var "access_key" .) "") (ne (var "secret_key" .) "") ]]
          "-s3.config=/local/s3config.json",
          [[- end ]]
        ]

        # Persistent named volume for all state (object data + metadata).
        # SeaweedFS runs as root, so a fresh volume is writable.
        mount {
          type   = "volume"
          source = "[[ var "data_volume" . ]]"
          target = "/data"
        }
      }

      [[- if and (ne (var "access_key" .) "") (ne (var "secret_key" .) "") ]]
      # S3 identity config, rendered from vars. Presence of any identity makes
      # authentication mandatory for every S3 request.
      template {
        destination = "local/s3config.json"
        perms       = "0600"
        data        = <<EOH
{
  "identities": [
    {
      "name": "admin",
      "credentials": [
        {
          "accessKey": "[[ var "access_key" . ]]",
          "secretKey": "[[ var "secret_key" . ]]"
        }
      ],
      "actions": ["Admin", "Read", "Write", "List", "Tagging", "Read_ACP", "Write_ACP"]
    }
  ]
}
EOH
      }
      [[- end ]]

      resources {
        cpu    = [[ (var "resources" .).cpu ]]
        memory = [[ (var "resources" .).memory ]]
      }
    }
  }
}
