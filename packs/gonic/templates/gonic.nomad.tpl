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

    network {
      mode = "host"
      port "http" {
        static = [[ var "port" . ]]
      }
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

    # Make the data volume writable regardless of the image's runtime user.
    task "init" {
      driver = "docker"

      lifecycle {
        hook    = "prestart"
        sidecar = false
      }

      config {
        image   = "busybox:latest"
        command = "sh"
        args    = ["-c", "chmod -R 0777 /data /podcasts /playlists"]

        mount {
          type   = "volume"
          source = "[[ var "data_volume" . ]]"
          target = "/data"
        }
        mount {
          type   = "volume"
          source = "[[ var "podcasts_volume" . ]]"
          target = "/podcasts"
        }
        mount {
          type   = "volume"
          source = "[[ var "playlists_volume" . ]]"
          target = "/playlists"
        }
      }

      resources {
        cpu    = 50
        memory = 64
      }
    }

    task "gonic" {
      driver = "docker"

      config {
        image        = "[[ var "image" . ]]"
        network_mode = "host"
        ports        = ["http"]
        mount {
          type   = "volume"
          target = "/data"
          source = "[[ var "data_volume" . ]]"
        }
        mount {
          type   = "volume"
          target = "/music"
          source = "[[ var "music_volume" . ]]"
        }
        mount {
          type   = "volume"
          target = "/podcasts"
          source = "[[ var "podcasts_volume" . ]]"
        }
        mount {
          type   = "volume"
          target = "/playlists"
          source = "[[ var "playlists_volume" . ]]"
        }
      }

      env {
        GONIC_LISTEN_ADDR    = "0.0.0.0:[[ var "port" . ]]"
        GONIC_MUSIC_PATH     = "/music"
        GONIC_PODCAST_PATH   = "/podcasts"
        GONIC_PLAYLISTS_PATH = "/playlists"
        GONIC_CACHE_PATH     = "/data/cache"
        GONIC_DB_PATH        = "/data/gonic.db"
      }

      resources {
        cpu    = [[ (var "resources" .).cpu ]]
        memory = [[ (var "resources" .).memory ]]
      }
    }
  }
}
