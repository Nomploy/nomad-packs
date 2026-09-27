variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "netalertx"
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
  description = "The NetAlertX container image. Pin a tag in production."
  type        = string
  default     = "ghcr.io/netalertx/netalertx:latest"
}

variable "port" {
  description = "Host port for the NetAlertX web UI."
  type        = number
  default     = 20211
}

variable "graphql_port" {
  description = "Host port for the internal GraphQL API."
  type        = number
  default     = 20214
}

variable "data_volume" {
  description = "Named volume for NetAlertX config and database (contains config/ and db/)."
  type        = string
  default     = "netalertx_data"
}

variable "constraints" {
  description = "Placement constraints. On a nomploy cluster: attribute = \"$${meta.nomploy_control_plane}\", operator = \"=\", value = \"true\". Pin to the node whose LAN you want scanned."
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
    cpu    = 500
    memory = 512
  }
}
