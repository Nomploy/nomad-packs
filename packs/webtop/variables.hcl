variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "webtop"
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
  description = "The Webtop image. Pick a flavor tag (e.g. ubuntu-xfce, alpine-kde, debian-mate). Pin a tag in production."
  type        = string
  default     = "lscr.io/linuxserver/webtop:ubuntu-xfce"
}

variable "port" {
  description = "Host port for the web desktop. The container listens on 3000."
  type        = number
  default     = 3000
}

variable "puid" {
  description = "User ID the desktop runs as (PUID)."
  type        = number
  default     = 1000
}

variable "pgid" {
  description = "Group ID the desktop runs as (PGID)."
  type        = number
  default     = 1000
}

variable "tz" {
  description = "Container timezone (TZ), e.g. Europe/Bratislava."
  type        = string
  default     = "UTC"
}

variable "shm_size" {
  description = "Shared-memory size in bytes (browsers/apps in the desktop need a large /dev/shm)."
  type        = number
  default     = 1073741824
}

variable "config_volume" {
  description = "Named volume for the desktop home / config (/config)."
  type        = string
  default     = "webtop_config"
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
  description = "Resources for the Webtop task. A desktop needs generous CPU/RAM."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 2000
    memory = 2048
  }
}
