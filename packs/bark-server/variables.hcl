variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "bark-server"
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
  description = "The Bark server container image. Pin a tag in production."
  type        = string
  default     = "finab/bark-server:latest"
}

variable "port" {
  description = "Host port for the Bark server HTTP API."
  type        = number
  default     = 8080
}

variable "data_volume" {
  description = "Named volume for Bark's device database."
  type        = string
  default     = "bark_data"
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
  description = "Resources for the Bark server task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 200
    memory = 128
  }
}
