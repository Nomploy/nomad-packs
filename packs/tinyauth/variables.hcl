variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "tinyauth"
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
  description = "The Tinyauth container image. Pin a tag in production."
  type        = string
  default     = "ghcr.io/tinyauthapp/tinyauth:v5"
}

variable "port" {
  description = "Host port for the Tinyauth server."
  type        = number
  default     = 3000
}

variable "app_url" {
  description = "Public URL where Tinyauth is served (required), e.g. https://tinyauth.example.com."
  type        = string
  default     = "http://localhost:3000"
}

variable "secret" {
  description = "Exactly 32-character secret used to sign session cookies. CHANGE THIS."
  type        = string
  default     = "changeme_changeme_changeme_12345"
}

variable "users" {
  description = "Login users as username:bcrypthash (comma-separate multiple). Default is user:password — CHANGE THIS. Generate with `tinyauth user create`."
  type        = string
  default     = "user:$2a$10$UdLYoJ5lgPsC0RKqYH/jMua7zIn0g9kPqWmhYayJYLaZQ/FTmH2/u"
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
