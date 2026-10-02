variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "omni-tools"
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
  description = "The OmniTools container image. Pin a tag in production."
  type        = string
  default     = "ghcr.io/iib0011/omni-tools:latest"
}

variable "port" {
  description = "Host port for the OmniTools web UI."
  type        = number
  default     = 8080
}

variable "count" {
  description = "Number of instances to run (the app is stateless)."
  type        = number
  default     = 1
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
  description = "Resources for the OmniTools task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 200
    memory = 128
  }
}
