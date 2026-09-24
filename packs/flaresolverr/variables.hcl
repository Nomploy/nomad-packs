variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "flaresolverr"
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
  description = "The FlareSolverr container image. Pin a tag in production."
  type        = string
  default     = "ghcr.io/flaresolverr/flaresolverr:latest"
}

variable "port" {
  description = "Host port for the FlareSolverr API (PORT)."
  type        = number
  default     = 8191
}

variable "log_level" {
  description = "Logging verbosity (LOG_LEVEL): info or debug."
  type        = string
  default     = "info"
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
  description = "Resources for the FlareSolverr task. It runs a headless browser, so give it some memory."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 500
    memory = 512
  }
}
