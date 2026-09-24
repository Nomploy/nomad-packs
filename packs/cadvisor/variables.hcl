variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "cadvisor"
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
  description = "The cAdvisor container image. Pin a tag in production."
  type        = string
  default     = "gcr.io/cadvisor/cadvisor:latest"
}

variable "port" {
  description = "Host port for the cAdvisor UI / Prometheus metrics (--port)."
  type        = number
  default     = 8080
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
  description = "Resources for the cAdvisor task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 300
    memory = 256
  }
}
