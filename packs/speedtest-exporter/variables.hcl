variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "speedtest-exporter"
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
  description = "The Speedtest Exporter container image. Pin a tag in production."
  type        = string
  default     = "ghcr.io/miguelndecarvalho/speedtest-exporter:latest"
}

variable "port" {
  description = "Host port for the Speedtest Exporter web UI."
  type        = number
  default     = 9798
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
