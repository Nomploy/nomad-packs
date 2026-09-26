variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "calibre"
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
  description = "The Calibre container image. Pin a tag in production."
  type        = string
  default     = "lscr.io/linuxserver/calibre:latest"
}

variable "port" {
  description = "Host port for the Calibre desktop GUI (browser-streamed)."
  type        = number
  default     = 8080
}

variable "content_port" {
  description = "Host port for the Calibre built-in content server (enable it in Calibre: Preferences > Sharing over the net)."
  type        = number
  default     = 8081
}

variable "data_volume" {
  description = "Named volume mounted at /config — Calibre's settings and your library."
  type        = string
  default     = "calibre_data"
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

variable "password" {
  description = "Optional password for the desktop GUI (PASSWORD). Empty = no GUI password (put it behind a reverse proxy)."
  type        = string
  default     = ""
}

variable "shm_size" {
  description = "Shared-memory size in bytes for the browser-streamed desktop."
  type        = number
  default     = 1073741824
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
    cpu    = 2000
    memory = 2048
  }
}
