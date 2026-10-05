variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "gokapi"
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
  description = "The Gokapi container image. Pin a tag in production."
  type        = string
  default     = "f0rc3/gokapi:latest"
}

variable "port" {
  description = "Host port for the Gokapi web UI."
  type        = number
  default     = 53842
}

variable "data_volume" {
  description = "Named volume for uploaded files and the SQLite database."
  type        = string
  default     = "gokapi_data"
}

variable "config_volume" {
  description = "Named volume for Gokapi configuration."
  type        = string
  default     = "gokapi_config"
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
  description = "Resources for the Gokapi task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 300
    memory = 256
  }
}
