variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "sabnzbd"
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
  description = "The SABnzbd container image. Pin a tag in production."
  type        = string
  default     = "lscr.io/linuxserver/sabnzbd:latest"
}

variable "port" {
  description = "Host port for the SABnzbd web UI. The container listens on 8080."
  type        = number
  default     = 8080
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
  description = "Named volume for SABnzbd config (/config): settings and history."
  type        = string
  default     = "sabnzbd_config"
}

variable "data_volume" {
  description = "Named volume for downloads (/data). Share this with the *arr packs for hardlinks/atomic moves."
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
  description = "Resources for the SABnzbd task. Par2 repair and unpacking are CPU-bound."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 1000
    memory = 512
  }
}
