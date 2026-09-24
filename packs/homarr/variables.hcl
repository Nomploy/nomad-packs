variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "homarr"
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
  description = "The Homarr container image. Pin a tag in production."
  type        = string
  default     = "ghcr.io/homarr-labs/homarr:latest"
}

variable "port" {
  description = "Host port for the Homarr web UI. The container listens on 7575."
  type        = number
  default     = 7575
}

variable "secret_encryption_key" {
  description = "64-character hex key used to encrypt secrets in the database (SECRET_ENCRYPTION_KEY). CHANGE THIS and keep it stable — generate with: openssl rand -hex 32."
  type        = string
  default     = "change-me-generate-with-openssl-rand-hex-32-0000000000000000"
}

variable "data_volume" {
  description = "Named volume for Homarr data (/appdata): the database, boards, and config."
  type        = string
  default     = "homarr_data"
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
  description = "Resources for the Homarr task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 500
    memory = 512
  }
}
