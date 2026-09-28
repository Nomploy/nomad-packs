variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "anonymousoverflow"
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
  description = "The AnonymousOverflow container image. Pin a tag in production."
  type        = string
  default     = "ghcr.io/httpjamesm/anonymousoverflow:latest"
}

variable "port" {
  description = "Host port for the AnonymousOverflow web UI."
  type        = number
  default     = 8080
}

variable "app_url" {
  description = "Public URL where this instance is served (required), e.g. https://ao.example.com."
  type        = string
  default     = "http://localhost:8080"
}

variable "jwt_signing_secret" {
  description = "Secret used to sign JWT cookies. CHANGE THIS to a long random value."
  type        = string
  default     = "change_me_to_a_long_random_jwt_secret_0000"
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
    cpu    = 200
    memory = 128
  }
}
