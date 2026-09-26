variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "gonic"
}

variable "namespace" {
  description = "The Nomad namespace to deploy into."
  type        = string
  default     = "default"
}

variable "datacenters" {
  description = "The datacenters to deploy to."
  type        = list(string)
  default     = ["*"]
}

variable "image" {
  description = "The gonic container image. Pin a tag in production."
  type        = string
  default     = "sentriz/gonic:latest"
}

variable "port" {
  description = "Host port for the gonic web UI."
  type        = number
  default     = 4747
}

variable "data_volume" {
  description = "Named volume mounted at /data (the SQLite database and caches)."
  type        = string
  default     = "gonic_data"
}

variable "music_volume" {
  description = "Named volume mounted at /music — your music library."
  type        = string
  default     = "gonic_music"
}

variable "podcasts_volume" {
  description = "Named volume mounted at /podcasts — downloaded podcasts."
  type        = string
  default     = "gonic_podcasts"
}

variable "playlists_volume" {
  description = "Named volume mounted at /playlists — M3U playlists."
  type        = string
  default     = "gonic_playlists"
}

variable "constraints" {
  description = "Placement constraints. On a nomploy cluster: attribute = \"$${meta.nomploy_control_plane}\", operator = \"=\", value = \"true\"."
  type = list(object({
    attribute = string
    operator  = string
    value     = string
  }))
  default = []
}

variable "resources" {
  description = "The task resources."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 300
    memory = 256
  }
}
