variable "job_name" {
  description = "The name of the Nomad job."
  type        = string
  default     = "convertx"
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
  description = "The ConvertX container image. Pin a tag in production."
  type        = string
  default     = "ghcr.io/c4illin/convertx:latest"
}

variable "port" {
  description = "Host port for the ConvertX web UI."
  type        = number
  default     = 3000
}

variable "data_volume" {
  description = "Named volume mounted at /app/data (SQLite database + converted files)."
  type        = string
  default     = "convertx_data"
}

variable "jwt_secret" {
  description = "Secret used to sign session tokens (JWT_SECRET). CHANGE THIS. Generate with: openssl rand -base64 36."
  type        = string
  default     = "change-me-openssl-rand-base64-36"
}

variable "puid" {
  description = "User ID that owns the files (PUID)."
  type        = number
  default     = 1000
}

variable "pgid" {
  description = "Group ID that owns the files (PGID)."
  type        = number
  default     = 1000
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
    cpu    = 300
    memory = 256
  }
}
