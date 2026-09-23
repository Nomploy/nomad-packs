variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "kroki"
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
  description = "The Kroki container image. Pin a tag in production."
  type        = string
  default     = "yuzutech/kroki:latest"
}

variable "port" {
  description = "Host port for the Kroki HTTP API (MICRONAUT_SERVER_PORT)."
  type        = number
  default     = 8125
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
    cpu    = 500
    memory = 512
  }
}
