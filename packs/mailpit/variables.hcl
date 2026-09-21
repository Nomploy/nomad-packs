variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "mailpit"
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
  description = "The Mailpit container image. Pin a tag in production."
  type        = string
  default     = "axllent/mailpit:latest"
}

variable "ui_port" {
  description = "Host port for the Mailpit web UI / API."
  type        = number
  default     = 8025
}

variable "smtp_port" {
  description = "Host port for the SMTP listener — point your app's SMTP client here."
  type        = number
  default     = 1025
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
    cpu    = 200
    memory = 128
  }
}
