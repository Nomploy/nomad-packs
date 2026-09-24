variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "libsql"
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
  description = "The libsql-server (sqld) image. Pin a tag in production."
  type        = string
  default     = "ghcr.io/tursodatabase/libsql-server:latest"
}

variable "port" {
  description = "Host port for the HTTP API (SQLD_HTTP_LISTEN_ADDR)."
  type        = number
  default     = 8121
}

variable "auth_jwt_key" {
  description = "Optional JWT public key (SQLD_AUTH_JWT_KEY) to require authenticated access. Empty = no auth (anyone who can reach the port has full access)."
  type        = string
  default     = ""
}

variable "data_volume" {
  description = "Named volume for the database files (/var/lib/sqld)."
  type        = string
  default     = "libsql_data"
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
  description = "Resources for the libsql task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 500
    memory = 256
  }
}
