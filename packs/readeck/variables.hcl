variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "readeck"
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
  description = "The Readeck container image. Pin a tag in production."
  type        = string
  default     = "codeberg.org/readeck/readeck:latest"
}

variable "port" {
  description = "Host port for the Readeck web UI (READECK_SERVER_PORT)."
  type        = number
  default     = 8000
}

variable "data_volume" {
  description = "Named volume for Readeck data (/readeck): the SQLite database and saved articles."
  type        = string
  default     = "readeck_data"
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
  description = "Resources for the Readeck task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 300
    memory = 256
  }
}
