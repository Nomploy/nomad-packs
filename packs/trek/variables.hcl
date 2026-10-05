variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "trek"
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
  description = "The TREK container image. Pin a tag in production."
  type        = string
  default     = "mauriceboe/trek:latest"
}

variable "port" {
  description = "Host port for the TREK web UI."
  type        = number
  default     = 3000
}

variable "encryption_key" {
  description = "Key used to encrypt stored secrets (e.g. integration API keys). Use a long random string (openssl rand -base64 32). CHANGE THIS and keep it stable."
  type        = string
  default     = "change_me_encryption_key_to_a_long_random_value"
}

variable "allowed_origins" {
  description = "Comma-separated list of allowed origins (CORS). Leave blank to allow the default; set to your public URL(s) in production."
  type        = string
  default     = ""
}

variable "timezone" {
  description = "Container timezone."
  type        = string
  default     = "UTC"
}

variable "data_volume" {
  description = "Named volume for TREK's SQLite database and data."
  type        = string
  default     = "trek_data"
}

variable "uploads_volume" {
  description = "Named volume for uploaded files."
  type        = string
  default     = "trek_uploads"
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
  description = "Resources for the TREK task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 500
    memory = 512
  }
}
