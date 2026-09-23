variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "gotenberg"
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
  description = "The Gotenberg container image. Pin a tag in production."
  type        = string
  default     = "gotenberg/gotenberg:8"
}

variable "port" {
  description = "Host port for the Gotenberg API (--api-port)."
  type        = number
  default     = 3015
}

variable "count" {
  description = "How many instances to run. Gotenberg is stateless, so you can run several behind a load balancer."
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
  description = "Resources for the Gotenberg task. Chromium/LibreOffice conversions can spike CPU and memory."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 1000
    memory = 1024
  }
}
