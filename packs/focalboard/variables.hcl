variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "focalboard"
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
  description = "The Focalboard container image. Pin a tag in production."
  type        = string
  default     = "mattermost/focalboard:latest"
}

variable "port" {
  description = "Host port for the Focalboard web UI. The container listens on 8000."
  type        = number
  default     = 8000
}

variable "data_volume" {
  description = "Named volume for Focalboard data (/opt/focalboard/data): the SQLite database, files, and config."
  type        = string
  default     = "focalboard_data"
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
  description = "Resources for the Focalboard task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 300
    memory = 256
  }
}
