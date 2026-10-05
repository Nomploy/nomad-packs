variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "arcane"
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
  description = "The Arcane container image. Pin a tag in production."
  type        = string
  default     = "ghcr.io/getarcaneapp/arcane:latest"
}

variable "port" {
  description = "Host port for the Arcane web UI."
  type        = number
  default     = 3552
}

variable "app_url" {
  description = "Public URL of this Arcane instance (used for links and callbacks). Set to your domain in production."
  type        = string
  default     = "http://localhost:3552"
}

variable "encryption_key" {
  description = "32-character key used to encrypt stored secrets. CHANGE THIS and keep it stable."
  type        = string
  default     = "change_me_32char_encryption_key!"
}

variable "jwt_secret" {
  description = "Secret used to sign auth sessions (openssl rand -base64 32). CHANGE THIS and keep it stable."
  type        = string
  default     = "change_me_jwt_secret_to_a_long_random_value"
}

variable "docker_socket" {
  description = "Path to the host Docker socket Arcane manages."
  type        = string
  default     = "/var/run/docker.sock"
}

variable "data_volume" {
  description = "Named volume for Arcane's SQLite database and state."
  type        = string
  default     = "arcane_data"
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
  description = "Resources for the Arcane task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 400
    memory = 512
  }
}
