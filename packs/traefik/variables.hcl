variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "traefik"
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
  description = "The Traefik container image. Pin a tag in production."
  type        = string
  default     = "traefik:v3.3"
}

variable "http_port" {
  description = "Host port for the HTTP entrypoint (web)."
  type        = number
  default     = 80
}

variable "https_port" {
  description = "Host port for the HTTPS entrypoint (websecure)."
  type        = number
  default     = 443
}

variable "dashboard_port" {
  description = "Host port for the Traefik dashboard/API (served insecurely — keep it internal)."
  type        = number
  default     = 8080
}

variable "nomad_address" {
  description = "Nomad HTTP API address Traefik reads services from (--providers.nomad.endpoint.address)."
  type        = string
  default     = "http://127.0.0.1:4646"
}

variable "nomad_token" {
  description = "Optional Nomad ACL token for the provider (--providers.nomad.endpoint.token). Empty if ACLs are disabled."
  type        = string
  default     = ""
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
  description = "Resources for the Traefik task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 500
    memory = 256
  }
}
