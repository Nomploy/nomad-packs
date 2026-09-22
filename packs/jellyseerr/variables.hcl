variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "jellyseerr"
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
  description = "The Jellyseerr container image. Pin a tag in production."
  type        = string
  default     = "fallenbagel/jellyseerr:latest"
}

variable "port" {
  description = "Host port for the Jellyseerr web UI (PORT)."
  type        = number
  default     = 5055
}

variable "log_level" {
  description = "Log verbosity (LOG_LEVEL): debug, info, warn, error."
  type        = string
  default     = "info"
}

variable "data_volume" {
  description = "Named volume for Jellyseerr config and its SQLite database (/app/config)."
  type        = string
  default     = "jellyseerr_config"
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
  description = "The task resources."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 500
    memory = 512
  }
}
