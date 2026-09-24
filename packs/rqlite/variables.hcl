variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "rqlite"
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
  description = "The rqlite container image. Pin a tag in production."
  type        = string
  default     = "rqlite/rqlite:latest"
}

variable "http_port" {
  description = "Host port for the HTTP API (-http-addr)."
  type        = number
  default     = 4001
}

variable "raft_port" {
  description = "Host port for the Raft consensus protocol (-raft-addr)."
  type        = number
  default     = 4002
}

variable "data_volume" {
  description = "Named volume for rqlite data (/rqlite/file): the SQLite database and Raft log."
  type        = string
  default     = "rqlite_data"
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
  description = "Resources for the rqlite task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 300
    memory = 256
  }
}
