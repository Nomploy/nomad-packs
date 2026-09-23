variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "flame"
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
  description = "The Flame container image. Pin a tag in production."
  type        = string
  default     = "pawelmalak/flame:latest"
}

variable "port" {
  description = "Host port for the Flame dashboard."
  type        = number
  default     = 5005
}

variable "password" {
  description = "Password for edit/admin mode (PASSWORD). Viewing is public; changes require this."
  type        = string
  default     = "changeme-please"
}

variable "data_volume" {
  description = "Named volume for the SQLite database and uploads (/app/data)."
  type        = string
  default     = "flame_data"
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
    cpu    = 200
    memory = 128
  }
}
