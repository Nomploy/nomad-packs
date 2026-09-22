variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "glances"
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
  description = "The Glances container image (use a *-full tag for the web UI + all sensors). Pin a tag in production."
  type        = string
  default     = "nicolargo/glances:latest-full"
}

variable "port" {
  description = "Host port for the Glances web dashboard / REST API."
  type        = number
  default     = 61208
}

variable "docker_socket" {
  description = "Mount the Docker socket read-only so Glances shows per-container stats."
  type        = bool
  default     = true
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
