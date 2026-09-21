variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "whoami"
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
  description = "The whoami container image."
  type        = string
  default     = "traefik/whoami:latest"
}

variable "port" {
  description = "Host port whoami listens on."
  type        = number
  default     = 8097
}

variable "count" {
  description = "Number of instances (stateless — >1 is useful for testing load balancing across replicas)."
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
  description = "The task resources."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 100
    memory = 32
  }
}
