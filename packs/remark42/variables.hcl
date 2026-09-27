variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "remark42"
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
  description = "The Remark42 container image. Pin a tag in production."
  type        = string
  default     = "umputun/remark42:latest"
}

variable "port" {
  description = "Host port for Remark42."
  type        = number
  default     = 8080
}

variable "remark_url" {
  description = "Public URL where Remark42 is served (required), e.g. https://comments.example.com."
  type        = string
  default     = "http://localhost:8080"
}

variable "secret" {
  description = "Secret key used to sign auth tokens. CHANGE THIS to a long random value."
  type        = string
  default     = "change_me_to_a_long_random_secret_0000000000000000"
}

variable "site" {
  description = "Site identifier(s) this instance serves comments for."
  type        = string
  default     = "remark"
}

variable "auth_anon" {
  description = "Allow anonymous commenting (true/false)."
  type        = string
  default     = "true"
}

variable "data_volume" {
  description = "Named volume for comments and backups (/srv/var)."
  type        = string
  default     = "remark42_data"
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
