variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "traccar"
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
  description = "The Traccar container image. Pin a tag in production."
  type        = string
  default     = "traccar/traccar:latest"
}

variable "port" {
  description = "Host port for the Traccar web UI."
  type        = number
  default     = 8082
}

variable "data_volume" {
  description = "Named volume for the embedded H2 database and data (/opt/traccar/data)."
  type        = string
  default     = "traccar_data"
}

variable "logs_volume" {
  description = "Named volume for Traccar logs (/opt/traccar/logs)."
  type        = string
  default     = "traccar_logs"
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
    memory = 1024
  }
}
