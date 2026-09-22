variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "weaviate"
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
  description = "The Weaviate container image. Pin a tag in production."
  type        = string
  default     = "cr.weaviate.io/semitechnologies/weaviate:latest"
}

variable "port" {
  description = "Host port for the Weaviate REST + GraphQL API."
  type        = number
  default     = 8087
}

variable "grpc_port" {
  description = "Host port for the Weaviate gRPC API (used by the v4 clients)."
  type        = number
  default     = 50051
}

variable "anonymous_access" {
  description = "Allow unauthenticated access. Ignored when api_key is set."
  type        = bool
  default     = true
}

variable "api_key" {
  description = "If set, enables API-key auth with this key (and disables anonymous access)."
  type        = string
  default     = ""
}

variable "data_volume" {
  description = "Named volume for Weaviate's data (/var/lib/weaviate)."
  type        = string
  default     = "weaviate_data"
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
    cpu    = 1000
    memory = 1024
  }
}
