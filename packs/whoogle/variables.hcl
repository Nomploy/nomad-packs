variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "whoogle"
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
  description = "The Whoogle Search container image. Pin a tag in production."
  type        = string
  default     = "benbusby/whoogle-search:latest"
}

variable "port" {
  description = "Host port for the Whoogle web UI (EXPOSE_PORT)."
  type        = number
  default     = 5010
}

variable "username" {
  description = "Optional HTTP basic-auth username (WHOOGLE_USER). Empty for both = no auth."
  type        = string
  default     = ""
}

variable "password" {
  description = "Optional HTTP basic-auth password (WHOOGLE_PASS)."
  type        = string
  default     = ""
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
