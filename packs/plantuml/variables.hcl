variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "plantuml"
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
  description = "The PlantUML Server container image. Pin a tag in production."
  type        = string
  default     = "plantuml/plantuml-server:jetty"
}

variable "port" {
  description = "Host port for the PlantUML Server web UI. Fixed at 8080 inside the Jetty image."
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
