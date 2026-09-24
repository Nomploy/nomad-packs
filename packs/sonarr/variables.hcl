variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "sonarr"
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
  description = "The Sonarr container image. Pin a tag in production."
  type        = string
  default     = "lscr.io/linuxserver/sonarr:latest"
}

variable "port" {
  description = "Host port for the Sonarr web UI."
  type        = number
  default     = 8989
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
  description = "Named volume for Sonarr config (/config): the database and settings."
  type        = string
  default     = "sonarr_config"
}

variable "data_volume" {
  description = "Named volume for media + downloads (/data): TV library and the download client's completed folder. Share this volume with your download client and media server for hardlinks/atomic moves."
  type        = string
  default     = "media_data"
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
  description = "Resources for the Sonarr task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 500
    memory = 512
  }
}
