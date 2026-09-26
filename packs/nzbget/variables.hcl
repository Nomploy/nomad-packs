variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "nzbget"
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
  description = "The NZBGet container image. Pin a tag in production."
  type        = string
  default     = "lscr.io/linuxserver/nzbget:latest"
}

variable "port" {
  description = "Host port for the NZBGet web UI."
  type        = number
  default     = 6789
}

variable "data_volume" {
  description = "Named volume mounted at /config (settings)."
  type        = string
  default     = "nzbget_data"
}

variable "downloads_volume" {
  description = "Named volume mounted at /downloads — completed and intermediate downloads."
  type        = string
  default     = "nzbget_downloads"
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

variable "username" {
  description = "Web UI username (NZBGET_USER)."
  type        = string
  default     = "nzbget"
}

variable "password" {
  description = "Web UI password (NZBGET_PASS). CHANGE THIS."
  type        = string
  default     = "tegbzn6789"
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
