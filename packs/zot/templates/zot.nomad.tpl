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

  group "[[ var "job_name" . ]]" {
    count = [[ var "count" . ]]

    restart {
      attempts = 3
      interval = "5m"
      delay    = "15s"
      mode     = "delay"
    }

    task "zot" {
      driver = "docker"

      config {
        image        = "[[ var "image" . ]]"
        force_pull   = true
        network_mode = "host"
        args         = ["serve", "/local/config.json"]
        volumes      = ["[[ var "data_dir" . ]]:[[ var "data_dir" . ]]"]
      }

      # zot config.json, rendered from pack variables (no host files needed).
      template {
        destination = "local/config.json"
        data        = <<EOH
{
  "distSpecVersion": "1.1.0",
  "storage": {
    "rootDirectory": "[[ var "data_dir" . ]]",
    "dedupe": true,
    "gc": true,
    "gcDelay": "1h",
    "gcInterval": "1h",
    "retention": { "policies": [{ "repositories": ["**"], "deleteUntagged": true }] }
  },
  "http": [[ if ne (var "htpasswd" .) "" ]]{
    "address": "0.0.0.0",
    "port": "[[ var "port" . ]]",
    "auth": { "htpasswd": { "path": "/local/htpasswd" } },
    "accessControl": { "repositories": { "**": {
      "anonymousPolicy": [[ if var "anonymous_pull" . ]][ "read" ][[ else ]][][[ end ]],
      "defaultPolicy": [ "read", "create" ]
    } } }
  }[[ else ]]{
    "address": "0.0.0.0",
    "port": "[[ var "port" . ]]"
  }[[ end ]],
  "log": { "level": "info" }
}
EOH
      }

      [[- if ne (var "htpasswd" .) "" ]]
      # user:bcrypthash line(s) for authenticated push.
      template {
        destination = "local/htpasswd"
        perms       = "0600"
        data        = <<EOH
[[ var "htpasswd" . ]]
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
