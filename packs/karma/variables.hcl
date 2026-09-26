variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "karma"
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
  description = "The Karma container image. Pin a tag in production."
  type        = string
  default     = "ghcr.io/prymitive/karma:latest"
}

variable "port" {
  description = "Host port for the Karma web UI."
  type        = number
  default     = 8080
}

variable "alertmanager_uri" {
  description = "URL of the Alertmanager to display (ALERTMANAGER_URI). On a nomploy node with the alertmanager pack, the default loopback works; otherwise point it at your Alertmanager."
  type        = string
  default     = "http://127.0.0.1:9093"
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
