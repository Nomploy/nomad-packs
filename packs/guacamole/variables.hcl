variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "guacamole"
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
  description = "The Apache Guacamole container image. Pin a tag in production."
  type        = string
  default     = "flcontainers/guacamole:latest"
}

variable "port" {
  description = "Host port for the Apache Guacamole web UI. Fixed at 8080 inside the image."
  type        = number
  default     = 8080
}

variable "data_volume" {
  description = "Named volume mounted at /config — the bundled PostgreSQL database and configuration."
  type        = string
  default     = "guacamole_data"
}

variable "tz" {
  description = "Container timezone (TZ), e.g. Europe/Bratislava."
  type        = string
  default     = "UTC"
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
