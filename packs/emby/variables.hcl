variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "emby"
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
  description = "The Emby container image. Pin a tag in production."
  type        = string
  default     = "lscr.io/linuxserver/emby:latest"
}

variable "port" {
  description = "Host port for the Emby web UI."
  type        = number
  default     = 8096
}

variable "data_volume" {
  description = "Named volume mounted at /config (Emby database and settings)."
  type        = string
  default     = "emby_data"
}

variable "media_volume" {
  description = "Named volume mounted at /data — your media library (movies, TV, music)."
  type        = string
  default     = "emby_media"
}

variable "puid" {
  description = "User ID that owns the files (PUID)."
  type        = number
  default     = 1000
}

variable "pgid" {
  description = "Group ID that owns the files (PGID)."
  type        = number
  default     = 1000
}

variable "tz" {
  description = "Container timezone (TZ), e.g. Europe/Bratislava."
  type        = string
  default     = "UTC"
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
