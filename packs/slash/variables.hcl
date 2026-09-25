variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "slash"
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
  description = "The Slash container image. Pin a tag in production."
  type        = string
  default     = "yourselfhosted/slash:latest"
}

variable "port" {
  description = "Host port for the Slash web UI."
  type        = number
  default     = 5231
}

variable "data_volume" {
  description = "Named volume mounted at /var/opt/slash."
  type        = string
  default     = "slash_data"
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
