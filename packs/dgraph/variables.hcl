variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "dgraph"
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
  description = "The Dgraph standalone container image. Pin a tag in production."
  type        = string
  default     = "dgraph/standalone:latest"
}

variable "http_port" {
  description = "Host port for the Alpha HTTP / GraphQL API."
  type        = number
  default     = 8080
}

variable "grpc_port" {
  description = "Host port for the Alpha gRPC API (client libraries)."
  type        = number
  default     = 9080
}

variable "data_volume" {
  description = "Named volume for Dgraph data (/dgraph)."
  type        = string
  default     = "dgraph_data"
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
  description = "The task resources."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 1000
    memory = 2048
  }
}
