variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "flowise"
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
  description = "The Flowise container image. Pin a tag in production."
  type        = string
  default     = "flowiseai/flowise:latest"
}

variable "port" {
  description = "Host port for the Flowise web UI / API (PORT)."
  type        = number
  default     = 3014
}

variable "username" {
  description = "App login username (FLOWISE_USERNAME). Empty for both = no login (open)."
  type        = string
  default     = "admin"
}

variable "password" {
  description = "App login password (FLOWISE_PASSWORD). CHANGE THIS."
  type        = string
  default     = "changeme-please"
}

variable "data_volume" {
  description = "Named volume for the Flowise database, API keys, and stored files (/root/.flowise)."
  type        = string
  default     = "flowise_data"
}

variable "constraints" {
  description = "Placement constraints. Pin to the node holding the volume. On a nomploy cluster: attribute = \"$${meta.nomploy_control_plane}\", operator = \"=\", value = \"true\"."
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
    cpu    = 1000
    memory = 1024
  }
}
