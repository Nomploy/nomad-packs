variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "ezbookkeeping"
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
  description = "The ezBookkeeping container image. Pin a tag in production."
  type        = string
  default     = "mayswind/ezbookkeeping:latest"
}

variable "port" {
  description = "Host port for the ezBookkeeping web UI."
  type        = number
  default     = 8080
}

variable "secret_key" {
  description = "Secret key used to sign auth tokens (openssl rand -base64 32). CHANGE THIS and keep it stable."
  type        = string
  default     = "change_me_secret_key_to_a_long_random_value"
}

variable "data_volume" {
  description = "Named volume for the SQLite database."
  type        = string
  default     = "ezbookkeeping_data"
}

variable "storage_volume" {
  description = "Named volume for uploaded files (avatars, attachments)."
  type        = string
  default     = "ezbookkeeping_storage"
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
  description = "Resources for the ezBookkeeping task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 300
    memory = 256
  }
}
