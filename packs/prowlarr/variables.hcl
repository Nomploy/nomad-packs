variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "prowlarr"
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
  description = "The Prowlarr container image. Pin a tag in production."
  type        = string
  default     = "lscr.io/linuxserver/prowlarr:latest"
}

variable "port" {
  description = "Host port for the Prowlarr web UI."
  type        = number
  default     = 9696
}

variable "puid" {
  description = "User ID the app runs as (PUID)."
  type        = number
  default     = 1000
}

variable "pgid" {
  description = "Group ID the app runs as (PGID)."
  type        = number
  default     = 1000
}

variable "tz" {
  description = "Container timezone (TZ), e.g. Europe/Bratislava."
  type        = string
  default     = "UTC"
}

variable "config_volume" {
  description = "Named volume for Prowlarr config (/config): the database, settings, and indexer definitions."
  type        = string
  default     = "prowlarr_config"
}

variable "constraints" {
  description = "Placement constraints. Pin to the node holding the volume. On a nomploy cluster: attribute = \"$${meta.nomploy_control_plane}\", operator = \"=\", value = \"true\"."
  type = list(object({
    attribute = string
    operator  = string
    value     = string
  }))
  default = []
}

variable "resources" {
  description = "Resources for the Prowlarr task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 300
    memory = 256
  }
}
