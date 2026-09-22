variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "navidrome"
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
  description = "The Navidrome container image. Pin a tag in production."
  type        = string
  default     = "deluan/navidrome:latest"
}

variable "port" {
  description = "Host port for the Navidrome web UI / Subsonic API."
  type        = number
  default     = 4533
}

variable "data_volume" {
  description = "Named volume for Navidrome's database, cache, and cover art (/data)."
  type        = string
  default     = "navidrome_data"
}

variable "music_volume" {
  description = "Named volume mounted read-only at /music — fill it with your library (e.g. via the syncthing pack or a host copy)."
  type        = string
  default     = "navidrome_music"
}

variable "constraints" {
  description = "Placement constraints. Pin to the node holding the volumes. On a nomploy cluster: attribute = \"$${meta.nomploy_control_plane}\", operator = \"=\", value = \"true\"."
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
    cpu    = 500
    memory = 256
  }
}
