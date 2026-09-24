variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "openfga"
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
  description = "The OpenFGA container image. Pin a tag in production."
  type        = string
  default     = "openfga/openfga:latest"
}

variable "http_port" {
  description = "Host port for the HTTP API (OPENFGA_HTTP_ADDR)."
  type        = number
  default     = 8080
}

variable "grpc_port" {
  description = "Host port for the gRPC API (OPENFGA_GRPC_ADDR)."
  type        = number
  default     = 8081
}

variable "playground_port" {
  description = "Host port for the web playground (OPENFGA_PLAYGROUND_PORT)."
  type        = number
  default     = 3000
}

variable "data_volume" {
  description = "Named volume for the SQLite datastore (/data, holds openfga.db)."
  type        = string
  default     = "openfga_data"
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
  description = "Resources for the OpenFGA task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 500
    memory = 256
  }
}
