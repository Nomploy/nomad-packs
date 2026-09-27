variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "tunarr"
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
  description = "The Tunarr container image. Pin a tag in production."
  type        = string
  default     = "chrisbenincasa/tunarr:latest"
}

variable "port" {
  description = "Host port for the Tunarr web UI."
  type        = number
  default     = 8000
}

variable "data_volume" {
  description = "Named volume mounted at /config/tunarr (database, settings and cache)."
  type        = string
  default     = "tunarr_data"
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
