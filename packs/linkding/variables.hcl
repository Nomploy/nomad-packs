variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "linkding"
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
  description = "The linkding container image. Pin a tag in production."
  type        = string
  default     = "sissbruecker/linkding:latest"
}

variable "port" {
  description = "Host port for the linkding web UI (LD_SERVER_PORT)."
  type        = number
  default     = 9091
}

variable "superuser_name" {
  description = "Initial admin username (LD_SUPERUSER_NAME). Created on first boot."
  type        = string
  default     = "admin"
}

variable "superuser_password" {
  description = "Initial admin password (LD_SUPERUSER_PASSWORD). CHANGE THIS."
  type        = string
  default     = "change-me-please"
}

variable "data_volume" {
  description = "Named volume for linkding data (/etc/linkding/data): the SQLite database and archived snapshots."
  type        = string
  default     = "linkding_data"
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
  description = "Resources for the linkding task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 300
    memory = 256
  }
}
