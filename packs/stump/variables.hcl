variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "stump"
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
  description = "The Stump container image. Pin a tag in production."
  type        = string
  default     = "aaronleopold/stump:latest"
}

variable "port" {
  description = "Host port for the Stump web UI. The container listens on 10801."
  type        = number
  default     = 10801
}

variable "puid" {
  description = "User ID Stump runs as / owns files (PUID)."
  type        = number
  default     = 1000
}

variable "pgid" {
  description = "Group ID Stump runs as (PGID)."
  type        = number
  default     = 1000
}

variable "config_volume" {
  description = "Named volume for Stump config (/config): the SQLite database, thumbnails, and logs."
  type        = string
  default     = "stump_config"
}

variable "library_volume" {
  description = "Named volume for your library files (/data): the comics, manga, and books Stump scans."
  type        = string
  default     = "stump_library"
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
  description = "Resources for the Stump task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 500
    memory = 256
  }
}
