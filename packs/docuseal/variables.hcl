variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "docuseal"
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
  description = "The DocuSeal container image. Pin a tag in production."
  type        = string
  default     = "docuseal/docuseal:latest"
}

variable "port" {
  description = "Host port for the DocuSeal web UI (PORT)."
  type        = number
  default     = 3026
}

variable "secret_key_base" {
  description = "Secret used to sign sessions and cookies (SECRET_KEY_BASE). CHANGE THIS — generate with: openssl rand -hex 64."
  type        = string
  default     = "change-me-openssl-rand-hex-64"
}

variable "data_volume" {
  description = "Named volume for DocuSeal data (/data): the SQLite database and uploaded documents."
  type        = string
  default     = "docuseal_data"
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
  description = "Resources for the DocuSeal task."
  type = object({
    cpu    = number
    memory = number
  })
  default = {
    cpu    = 500
    memory = 512
  }
}
