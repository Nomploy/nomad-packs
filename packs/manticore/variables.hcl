variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "manticore"
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
  description = "The Manticore Search container image. Pin a tag in production."
  type        = string
  default     = "manticoresearch/manticore:latest"
}

variable "sql_port" {
  description = "Host port for the MySQL-compatible SQL interface."
  type        = number
  default     = 9306
}

variable "http_port" {
  description = "Host port for the HTTP/JSON API."
  type        = number
  default     = 9308
}

variable "binary_port" {
  description = "Host port for the binary protocol (inter-node / replication)."
  type        = number
  default     = 9312
}

variable "data_volume" {
  description = "Named volume for Manticore data (/var/lib/manticore): all tables and indexes."
  type        = string
  default     = "manticore_data"
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
  description = "Resources for the Manticore task. Large indexes benefit from more memory."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 500
    memory = 512
  }
}
