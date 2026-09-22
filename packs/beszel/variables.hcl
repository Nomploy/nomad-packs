variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "beszel"
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
  description = "The Beszel hub container image. Pin a tag in production."
  type        = string
  default     = "henrygd/beszel:latest"
}

variable "port" {
  description = "Host port for the Beszel hub web UI."
  type        = number
  default     = 8090
}

variable "data_volume" {
  description = "Named volume for the Beszel hub data — SQLite database and config (/beszel_data)."
  type        = string
  default     = "beszel_data"
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
    cpu    = 200
    memory = 128
  }
}
