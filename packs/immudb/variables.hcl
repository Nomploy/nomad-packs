variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "immudb"
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
  description = "The immudb container image. Pin a tag in production."
  type        = string
  default     = "codenotary/immudb:latest"
}

variable "port" {
  description = "Host port for the immudb protocol (gRPC / MySQL & PostgreSQL wire), IMMUDB_PORT."
  type        = number
  default     = 3322
}

variable "web_port" {
  description = "Host port for the web console (IMMUDB_WEB_SERVER_PORT)."
  type        = number
  default     = 8085
}

variable "admin_password" {
  description = "Password for the default 'immudb' admin user (IMMUDB_ADMIN_PASSWORD). CHANGE THIS — must meet complexity rules (8+ chars, upper/lower/digit/symbol)."
  type        = string
  default     = "Change-me-1!"
}

variable "data_volume" {
  description = "Named volume for immudb data (/var/lib/immudb): all databases and their verifiable history."
  type        = string
  default     = "immudb_data"
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
  description = "Resources for the immudb task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 500
    memory = 512
  }
}
