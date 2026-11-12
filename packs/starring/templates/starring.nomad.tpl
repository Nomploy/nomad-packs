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
    count = 1

    # Bridge networking with dynamically-assigned host ports: two allocs of this
    # group can run on the SAME node at once (canary / rolling update), because
    # Nomad picks a free host port per alloc instead of pinning a fixed one. A
    # static host port made the canary unschedulable (port already held by the
    # running alloc) -> rollout never completed -> deploys never re-pulled the
    # image. Tasks in a group share one network namespace, so the app still
    # reaches the bundled DB over 127.0.0.1.
    network {
      mode = "bridge"
      port "http" {
        to = [[ var "port" . ]]
      }
      [[- if var "bundled_db" . ]]
      port "db" {
        to = [[ var "db_port" . ]]
      }
      [[- end ]]
    }

    service {
      name     = "[[ var "job_name" . ]]"
      provider = "nomad"
      port     = "http"
    }

    restart {
      attempts = 3
      interval = "5m"
      delay    = "15s"
      mode     = "delay"
    }

    [[- if var "bundled_db" . ]]
    task "postgres" {
      driver = "docker"

      lifecycle {
        hook    = "prestart"
        sidecar = true
      }

      config {
        image = "[[ var "postgres_image" . ]]"
        ports = ["db"]

        mount {
          type   = "volume"
          source = "[[ var "db_data_volume" . ]]"
          target = "/var/lib/postgresql/data"
        }
      }

      env {
        POSTGRES_DB       = "starring"
        POSTGRES_USER     = "starring"
        POSTGRES_PASSWORD = "[[ var "db_password" . ]]"
        PGPORT            = "[[ var "db_port" . ]]"
      }

      resources {
        cpu    = [[ (var "postgres_resources" .).cpu ]]
        memory = [[ (var "postgres_resources" .).memory ]]
      }
    }

    # Gate the app on PostgreSQL accepting connections so the first migration
    # doesn't race a cold database (ECONNREFUSED -> crash -> restart).
    task "wait-db" {
      driver = "docker"

      lifecycle {
        hook    = "prestart"
        sidecar = false
      }

      config {
        image   = "busybox:1.37"
        command = "sh"
        args         = ["-c", "for i in $(seq 1 180); do nc -w 2 127.0.0.1 [[ var "db_port" . ]] </dev/null >/dev/null 2>&1 && exit 0; echo waiting for postgres; sleep 1; done; echo 'timed out waiting for postgres'; exit 1"]
      }

      resources {
        cpu    = 50
        memory = 16
      }
    }
    [[- end ]]

    task "starring" {
      driver = "docker"

      config {
        image = "[[ var "image" . ]]"
        ports = ["http"]
      }

      env {
        STARRING_MODE      = "server"
        NODE_ENV           = "production"
        HOST               = "0.0.0.0"
        PORT               = "[[ var "port" . ]]"
        DATABASE_URL       = "[[ if var "bundled_db" . ]]postgres://starring:[[ var "db_password" . ]]@127.0.0.1:[[ var "db_port" . ]]/starring[[ else ]][[ var "database_url" . ]][[ end ]]"
        BETTER_AUTH_URL    = "[[ if ne (var "better_auth_url" .) "" ]][[ var "better_auth_url" . ]][[ else ]]http://localhost:[[ var "port" . ]][[ end ]]"
        BETTER_AUTH_SECRET = "[[ var "better_auth_secret" . ]]"
        SITE_URL           = "[[ var "site_url" . ]]"
        ALLOW_SIGNUP       = "[[ var "allow_signup" . ]]"
        AUTH_PASSWORD      = "[[ var "password_auth" . ]]"
        [[- range $k, $v := var "extra_env" . ]]
        [[ $k ]] = "[[ $v ]]"
        [[- end ]]
      }

      resources {
        cpu    = [[ (var "resources" .).cpu ]]
        memory = [[ (var "resources" .).memory ]]
      }
    }
  }
}
