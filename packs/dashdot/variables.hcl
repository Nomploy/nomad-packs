variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "dashdot"
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
  description = "The dashdot container image. Pin a tag in production."
  type        = string
  default     = "mauricenino/dashdot:latest"
}

variable "port" {
  description = "Host port for the dashboard. The container listens on 3001."
  type        = number
  default     = 3001
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
  description = "Resources for the dashdot task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 300
    memory = 256
  }
}
