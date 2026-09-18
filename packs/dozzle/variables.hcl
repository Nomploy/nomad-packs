variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "dozzle"
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
  description = "The Dozzle container image. Pin a tag in production."
  type        = string
  default     = "amir20/dozzle:latest"
}

variable "port" {
  description = "Host port for the Dozzle web UI. Default 8091 to avoid common clashes."
  type        = number
  default     = 8091
}

variable "constraints" {
  description = "Placement constraints. Dozzle shows the containers on the node it runs on, so pin it where you want to view logs. On a nomploy cluster: attribute = \"$${meta.nomploy_control_plane}\", operator = \"=\", value = \"true\"."
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
    cpu    = 200
    memory = 128
  }
}
